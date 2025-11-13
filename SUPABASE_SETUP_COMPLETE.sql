-- ========================================
-- MATCHUP - Complete Database Schema
-- ========================================
-- This script creates all tables, indexes, triggers, and RLS policies
-- Execute this entire script in Supabase SQL Editor

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- ========================================
-- USERS TABLE
-- ========================================

create table public.users (
  id uuid references auth.users on delete cascade not null primary key,
  username text not null unique,
  email text not null unique,
  first_name text,
  last_name text,
  date_of_birth date,
  gender text check (gender in ('male', 'female', 'other')),
  bio text,
  avatar_url text,
  city text,
  country text,
  latitude numeric(10, 8),
  longitude numeric(11, 8),
  looking_for text check (looking_for in ('male', 'female', 'both')),
  min_age integer default 18,
  max_age integer default 99,
  max_distance integer default 50,
  is_active boolean default true,
  is_verified boolean default false,
  last_active_at timestamp with time zone default now(),
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- ========================================
-- GALLERY TABLE
-- ========================================

create table public.gallery (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  photo_url text not null,
  position integer default 0,
  created_at timestamp with time zone default now()
);

-- ========================================
-- INTEREST TABLE
-- ========================================

create table public.interest (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  name text not null,
  created_at timestamp with time zone default now()
);

-- ========================================
-- MATCHES TABLE
-- ========================================

create table public.matches (
  id uuid default uuid_generate_v4() primary key,
  user1_id uuid references public.users(id) on delete cascade not null,
  user2_id uuid references public.users(id) on delete cascade not null,
  user1_liked boolean default false,
  user2_liked boolean default false,
  matched_at timestamp with time zone,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now(),
  constraint different_users check (user1_id <> user2_id),
  constraint unique_match unique (user1_id, user2_id)
);

-- ========================================
-- MESSAGE TABLE
-- ========================================

create table public.message (
  id uuid default uuid_generate_v4() primary key,
  match_id uuid references public.matches(id) on delete cascade not null,
  sender_id uuid references public.users(id) on delete cascade not null,
  content text not null,
  message_type text default 'text' check (message_type in ('text', 'image', 'gif')),
  is_read boolean default false,
  read_at timestamp with time zone,
  created_at timestamp with time zone default now()
);

-- ========================================
-- INDEXES FOR PERFORMANCE
-- ========================================

-- Users indexes
create index idx_users_username on public.users(username);
create index idx_users_email on public.users(email);
create index idx_users_gender on public.users(gender);
create index idx_users_looking_for on public.users(looking_for);
create index idx_users_city on public.users(city);
create index idx_users_is_active on public.users(is_active);
create index idx_users_last_active on public.users(last_active_at);
create index idx_users_location on public.users(latitude, longitude);

-- Gallery indexes
create index idx_gallery_user_id on public.gallery(user_id);
create index idx_gallery_position on public.gallery(position);

-- Interest indexes
create index idx_interest_user_id on public.interest(user_id);
create index idx_interest_name on public.interest(name);

-- Matches indexes
create index idx_matches_user1_id on public.matches(user1_id);
create index idx_matches_user2_id on public.matches(user2_id);
create index idx_matches_matched_at on public.matches(matched_at);
create index idx_matches_both_users on public.matches(user1_id, user2_id);

-- Message indexes
create index idx_message_match_id on public.message(match_id);
create index idx_message_sender_id on public.message(sender_id);
create index idx_message_created_at on public.message(created_at);
create index idx_message_is_read on public.message(is_read);

-- ========================================
-- TRIGGERS FOR UPDATED_AT
-- ========================================

-- Function to update updated_at timestamp
create or replace function public.handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Trigger for users table
create trigger set_updated_at
  before update on public.users
  for each row
  execute function public.handle_updated_at();

-- Trigger for matches table
create trigger set_updated_at
  before update on public.matches
  for each row
  execute function public.handle_updated_at();

-- ========================================
-- ROW LEVEL SECURITY (RLS)
-- ========================================

-- Enable RLS on all tables
alter table public.users enable row level security;
alter table public.gallery enable row level security;
alter table public.interest enable row level security;
alter table public.matches enable row level security;
alter table public.message enable row level security;

-- ========================================
-- USERS TABLE POLICIES
-- ========================================

-- Policy: Anyone can read active user profiles
create policy "Public profiles are viewable by authenticated users"
  on public.users for select
  to authenticated
  using (is_active = true);

-- Policy: Users can insert their own profile
create policy "Users can insert own profile"
  on public.users for insert
  to authenticated
  with check (auth.uid() = id);

-- Policy: Users can update only their own profile
create policy "Users can update own profile"
  on public.users for update
  to authenticated
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- Policy: Users can delete their own profile
create policy "Users can delete own profile"
  on public.users for delete
  to authenticated
  using (auth.uid() = id);

-- ========================================
-- GALLERY TABLE POLICIES
-- ========================================

-- Policy: Users can view their own gallery and others' galleries
create policy "Gallery photos are viewable"
  on public.gallery for select
  to authenticated
  using (true);

-- Policy: Users can insert photos to their own gallery
create policy "Users can insert own gallery photos"
  on public.gallery for insert
  to authenticated
  with check (auth.uid() = user_id);

-- Policy: Users can update their own gallery photos
create policy "Users can update own gallery photos"
  on public.gallery for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Policy: Users can delete their own gallery photos
create policy "Users can delete own gallery photos"
  on public.gallery for delete
  to authenticated
  using (auth.uid() = user_id);

-- ========================================
-- INTEREST TABLE POLICIES
-- ========================================

-- Policy: Interests are viewable by everyone
create policy "Interests are viewable"
  on public.interest for select
  to authenticated
  using (true);

-- Policy: Users can insert their own interests
create policy "Users can insert own interests"
  on public.interest for insert
  to authenticated
  with check (auth.uid() = user_id);

-- Policy: Users can update their own interests
create policy "Users can update own interests"
  on public.interest for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Policy: Users can delete their own interests
create policy "Users can delete own interests"
  on public.interest for delete
  to authenticated
  using (auth.uid() = user_id);

-- ========================================
-- MATCHES TABLE POLICIES
-- ========================================

-- Policy: Users can view matches they are part of
create policy "Users can view own matches"
  on public.matches for select
  to authenticated
  using (auth.uid() = user1_id or auth.uid() = user2_id);

-- Policy: Users can create matches
create policy "Users can create matches"
  on public.matches for insert
  to authenticated
  with check (auth.uid() = user1_id or auth.uid() = user2_id);

-- Policy: Users can update matches they are part of
create policy "Users can update own matches"
  on public.matches for update
  to authenticated
  using (auth.uid() = user1_id or auth.uid() = user2_id)
  with check (auth.uid() = user1_id or auth.uid() = user2_id);

-- Policy: Users can delete matches they are part of
create policy "Users can delete own matches"
  on public.matches for delete
  to authenticated
  using (auth.uid() = user1_id or auth.uid() = user2_id);

-- ========================================
-- MESSAGE TABLE POLICIES
-- ========================================

-- Policy: Users can view messages in their matches
create policy "Users can view messages in own matches"
  on public.message for select
  to authenticated
  using (
    exists (
      select 1 from public.matches
      where matches.id = message.match_id
      and (matches.user1_id = auth.uid() or matches.user2_id = auth.uid())
    )
  );

-- Policy: Users can send messages in their matches
create policy "Users can send messages in own matches"
  on public.message for insert
  to authenticated
  with check (
    auth.uid() = sender_id
    and exists (
      select 1 from public.matches
      where matches.id = message.match_id
      and (matches.user1_id = auth.uid() or matches.user2_id = auth.uid())
    )
  );

-- Policy: Users can update their own messages
create policy "Users can update own messages"
  on public.message for update
  to authenticated
  using (auth.uid() = sender_id)
  with check (auth.uid() = sender_id);

-- Policy: Users can delete their own messages
create policy "Users can delete own messages"
  on public.message for delete
  to authenticated
  using (auth.uid() = sender_id);

-- ========================================
-- REALTIME SUBSCRIPTIONS
-- ========================================

-- Enable realtime for matches and messages
alter publication supabase_realtime add table public.matches;
alter publication supabase_realtime add table public.message;

-- ========================================
-- COMPLETION MESSAGE
-- ========================================

-- If you see this message, the schema was created successfully!
-- Next steps: Configure Storage buckets and policies
