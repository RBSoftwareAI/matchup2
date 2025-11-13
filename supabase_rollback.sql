-- ==========================================
-- MATCHUP - SUPABASE DATABASE ROLLBACK
-- ==========================================
-- Version: 1.0.0
-- Description: Complete rollback script to remove all MatchUp database objects
--
-- WARNING: This script will permanently delete all data!
-- Use this only if you need to completely remove the database schema
-- 
-- EXECUTION: Run in Supabase SQL Editor
-- ==========================================

-- ==========================================
-- SECTION 1: DROP POLICIES
-- ==========================================
-- Drop in reverse order to avoid dependencies

-- Message table policies
drop policy if exists "Users can update received messages" on public.message;
drop policy if exists "Users can insert messages" on public.message;
drop policy if exists "Users can view own messages" on public.message;

-- Matches table policies
drop policy if exists "Users can delete sent matches" on public.matches;
drop policy if exists "Users can update received matches" on public.matches;
drop policy if exists "Users can insert matches" on public.matches;
drop policy if exists "Users can view own matches" on public.matches;

-- Interest table policies
drop policy if exists "Users can delete own interests" on public.interest;
drop policy if exists "Users can update own interests" on public.interest;
drop policy if exists "Users can insert own interests" on public.interest;
drop policy if exists "Users can view all interests" on public.interest;

-- Gallery table policies
drop policy if exists "Users can delete own gallery" on public.gallery;
drop policy if exists "Users can update own gallery" on public.gallery;
drop policy if exists "Users can insert own gallery" on public.gallery;
drop policy if exists "Users can view all gallery" on public.gallery;

-- Users table policies
drop policy if exists "Users can delete own profile" on public.users;
drop policy if exists "Users can update own profile" on public.users;
drop policy if exists "Users can insert own profile" on public.users;
drop policy if exists "Users can view all profiles" on public.users;

-- ==========================================
-- SECTION 2: DROP TRIGGERS
-- ==========================================

drop trigger if exists update_message_updated_at on public.message;
drop trigger if exists update_matches_updated_at on public.matches;
drop trigger if exists update_interest_updated_at on public.interest;
drop trigger if exists update_gallery_updated_at on public.gallery;
drop trigger if exists update_users_updated_at on public.users;

-- ==========================================
-- SECTION 3: DROP FUNCTIONS
-- ==========================================

drop function if exists public.update_updated_at_column();

-- ==========================================
-- SECTION 4: DROP INDEXES
-- ==========================================

-- Message indexes
drop index if exists public.idx_message_conversation;
drop index if exists public.idx_message_unread;
drop index if exists public.idx_message_created_at;
drop index if exists public.idx_message_seen;
drop index if exists public.idx_message_destination;
drop index if exists public.idx_message_sender;

-- Matches indexes
drop index if exists public.idx_matches_confirmed;
drop index if exists public.idx_matches_pending;
drop index if exists public.idx_matches_sender_receiver;
drop index if exists public.idx_matches_accepted;
drop index if exists public.idx_matches_receiver;
drop index if exists public.idx_matches_sender;

-- Interest indexes
drop index if exists public.idx_interest_name;
drop index if exists public.idx_interest_users_id;

-- Gallery indexes
drop index if exists public.idx_gallery_users_position;
drop index if exists public.idx_gallery_users_id;

-- Users indexes
drop index if exists public.idx_users_last_active;
drop index if exists public.idx_users_is_active;
drop index if exists public.idx_users_age;
drop index if exists public.idx_users_city;
drop index if exists public.idx_users_gender;

-- ==========================================
-- SECTION 5: DROP TABLES
-- ==========================================
-- Drop in reverse order of dependencies

drop table if exists public.message cascade;
drop table if exists public.matches cascade;
drop table if exists public.interest cascade;
drop table if exists public.gallery cascade;
drop table if exists public.users cascade;

-- ==========================================
-- SECTION 6: VERIFICATION
-- ==========================================
-- Verify all objects have been removed

-- Check if tables exist
select 
  tablename
from pg_tables
where schemaname = 'public'
  and tablename in ('users', 'gallery', 'interest', 'matches', 'message');

-- Check if policies exist
select
  tablename,
  policyname
from pg_policies
where schemaname = 'public'
  and tablename in ('users', 'gallery', 'interest', 'matches', 'message');

-- Check if triggers exist
select
  trigger_name,
  event_object_table
from information_schema.triggers
where trigger_schema = 'public'
  and event_object_table in ('users', 'gallery', 'interest', 'matches', 'message');

-- Check if functions exist
select
  routine_name
from information_schema.routines
where routine_schema = 'public'
  and routine_name = 'update_updated_at_column';

-- Check if indexes exist
select
  indexname,
  tablename
from pg_indexes
where schemaname = 'public'
  and tablename in ('users', 'gallery', 'interest', 'matches', 'message');

-- ==========================================
-- END OF ROLLBACK
-- ==========================================
-- All MatchUp database objects have been removed
--
-- If the verification queries return no results,
-- the rollback was successful.
--
-- To reinstall the schema, run: supabase_schema.sql
-- ==========================================
