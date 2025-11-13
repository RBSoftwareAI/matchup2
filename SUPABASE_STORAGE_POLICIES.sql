-- ========================================
-- MATCHUP - Storage Policies
-- ========================================
-- Execute this script in Supabase SQL Editor AFTER creating the buckets
-- 
-- PREREQUISITES:
-- 1. Create 3 public buckets: avatars, gallery, chat
-- 2. Tables (users, matches) must already exist
-- 
-- ========================================

-- ========================================
-- AVATARS BUCKET POLICIES
-- ========================================

-- Policy 1: Public read access
CREATE POLICY "Public read access for avatars"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'avatars');

-- Policy 2: Authenticated users can upload to their own folder
CREATE POLICY "Users can upload their own avatar"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Policy 3: Users can update their own files
CREATE POLICY "Users can update their own avatar"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
)
WITH CHECK (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Policy 4: Users can delete their own files
CREATE POLICY "Users can delete their own avatar"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- ========================================
-- GALLERY BUCKET POLICIES
-- ========================================

-- Policy 1: Public read access
CREATE POLICY "Public read access for gallery"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'gallery');

-- Policy 2: Authenticated users can upload to their own folder
CREATE POLICY "Users can upload to their own gallery"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'gallery' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Policy 3: Users can update their own files
CREATE POLICY "Users can update their own gallery photos"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'gallery' 
  AND (storage.foldername(name))[1] = auth.uid()::text
)
WITH CHECK (
  bucket_id = 'gallery' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Policy 4: Users can delete their own files
CREATE POLICY "Users can delete their own gallery photos"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'gallery' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- ========================================
-- CHAT BUCKET POLICIES
-- ========================================

-- Policy 1: Users can read images from their matches
CREATE POLICY "Users can read chat images from their matches"
ON storage.objects FOR SELECT
TO authenticated
USING (
  bucket_id = 'chat'
  AND EXISTS (
    SELECT 1 FROM public.matches
    WHERE matches.id::text = (storage.foldername(name))[1]
    AND (matches.user1_id = auth.uid() OR matches.user2_id = auth.uid())
  )
);

-- Policy 2: Users can upload images to their matches
CREATE POLICY "Users can upload images to their matches"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'chat'
  AND EXISTS (
    SELECT 1 FROM public.matches
    WHERE matches.id::text = (storage.foldername(name))[1]
    AND (matches.user1_id = auth.uid() OR matches.user2_id = auth.uid())
  )
);

-- Policy 3: Users can delete their own chat images
CREATE POLICY "Users can delete their own chat images"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'chat'
  AND EXISTS (
    SELECT 1 FROM public.matches
    WHERE matches.id::text = (storage.foldername(name))[1]
    AND (matches.user1_id = auth.uid() OR matches.user2_id = auth.uid())
  )
);

-- ========================================
-- VERIFICATION QUERY
-- ========================================

-- Run this query to verify all policies are created
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd
FROM pg_policies
WHERE tablename = 'objects'
ORDER BY policyname;

-- You should see 11 policies total:
-- - 4 for avatars (SELECT, INSERT, UPDATE, DELETE)
-- - 4 for gallery (SELECT, INSERT, UPDATE, DELETE)
-- - 3 for chat (SELECT, INSERT, DELETE)
