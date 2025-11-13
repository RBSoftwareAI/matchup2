/// Storage Service
/// 
/// Handles all file storage operations with Supabase Storage
/// - Upload images (profile, gallery)
/// - Delete images
/// - Get public URLs
/// - Upload to specific buckets
library;

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class StorageService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  // Storage bucket names
  static const String matchUpBucket = 'matchUp';

  /// Upload image to Supabase Storage
  /// 
  /// Uploads a file to specified path in the matchUp bucket
  /// Returns the path of the uploaded file
  /// 
  /// Example:
  /// ```dart
  /// final file = File('/path/to/image.jpg');
  /// final path = await storageService.uploadImage(
  ///   path: 'profiles/user-uuid/avatar.jpg',
  ///   file: file,
  /// );
  /// print('Uploaded to: $path');
  /// ```
  Future<String> uploadImage({
    required String path,
    required File file,
    String bucket = matchUpBucket,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final fileExt = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = '$path/$fileName';

      await _supabase.storage.from(bucket).uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              upsert: false,
              contentType: _getContentType(fileExt),
            ),
          );

      return filePath;
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  /// Upload profile picture
  /// 
  /// Uploads user's main profile picture
  /// 
  /// Example:
  /// ```dart
  /// final file = File('/path/to/avatar.jpg');
  /// final url = await storageService.uploadProfilePicture(
  ///   userId: 'user-uuid',
  ///   file: file,
  /// );
  /// ```
  Future<String> uploadProfilePicture({
    required String userId,
    required File file,
  }) async {
    try {
      final path = await uploadImage(
        path: 'profiles/$userId',
        file: file,
      );
      return getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  /// Upload gallery photo
  /// 
  /// Uploads a photo to user's gallery
  /// 
  /// Example:
  /// ```dart
  /// final file = File('/path/to/photo.jpg');
  /// final url = await storageService.uploadGalleryPhoto(
  ///   userId: 'user-uuid',
  ///   file: file,
  /// );
  /// ```
  Future<String> uploadGalleryPhoto({
    required String userId,
    required File file,
  }) async {
    try {
      final path = await uploadImage(
        path: 'gallery/$userId',
        file: file,
      );
      return getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to upload gallery photo: $e');
    }
  }

  /// Delete image from storage
  /// 
  /// Deletes a file from the specified bucket
  /// 
  /// Example:
  /// ```dart
  /// await storageService.deleteImage(
  ///   path: 'profiles/user-uuid/avatar.jpg',
  /// );
  /// ```
  Future<void> deleteImage({
    required String path,
    String bucket = matchUpBucket,
  }) async {
    try {
      await _supabase.storage.from(bucket).remove([path]);
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  /// Get public URL for an image
  /// 
  /// Returns the public URL for accessing an image
  /// 
  /// Example:
  /// ```dart
  /// final url = storageService.getPublicUrl(
  ///   'profiles/user-uuid/avatar.jpg',
  /// );
  /// ```
  String getPublicUrl(
    String path, {
    String bucket = matchUpBucket,
  }) {
    try {
      return _supabase.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      throw Exception('Failed to get public URL: $e');
    }
  }

  /// Get signed URL for private image
  /// 
  /// Returns a temporary signed URL for accessing a private image
  /// URL expires after specified duration
  /// 
  /// Example:
  /// ```dart
  /// final url = await storageService.getSignedUrl(
  ///   path: 'private/user-uuid/photo.jpg',
  ///   expiresIn: Duration(hours: 1),
  /// );
  /// ```
  Future<String> getSignedUrl({
    required String path,
    Duration expiresIn = const Duration(hours: 1),
    String bucket = matchUpBucket,
  }) async {
    try {
      final signedUrl = await _supabase.storage.from(bucket).createSignedUrl(
            path,
            expiresIn.inSeconds,
          );
      return signedUrl;
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } catch (e) {
      throw Exception('Failed to get signed URL: $e');
    }
  }

  /// List files in a path
  /// 
  /// Returns list of files in the specified path
  /// 
  /// Example:
  /// ```dart
  /// final files = await storageService.listFiles('profiles/user-uuid');
  /// for (var file in files) {
  ///   print('File: ${file.name}');
  /// }
  /// ```
  Future<List<FileObject>> listFiles({
    required String path,
    String bucket = matchUpBucket,
  }) async {
    try {
      final files = await _supabase.storage.from(bucket).list(path: path);
      return files;
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } catch (e) {
      throw Exception('Failed to list files: $e');
    }
  }

  /// Download image as bytes
  /// 
  /// Downloads an image and returns it as bytes
  /// 
  /// Example:
  /// ```dart
  /// final bytes = await storageService.downloadImage(
  ///   'profiles/user-uuid/avatar.jpg',
  /// );
  /// ```
  Future<List<int>> downloadImage({
    required String path,
    String bucket = matchUpBucket,
  }) async {
    try {
      final bytes = await _supabase.storage.from(bucket).download(path);
      return bytes;
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } catch (e) {
      throw Exception('Failed to download image: $e');
    }
  }

  /// Update image (replace existing)
  /// 
  /// Replaces an existing image with a new one
  /// 
  /// Example:
  /// ```dart
  /// final newFile = File('/path/to/new-image.jpg');
  /// await storageService.updateImage(
  ///   path: 'profiles/user-uuid/avatar.jpg',
  ///   file: newFile,
  /// );
  /// ```
  Future<void> updateImage({
    required String path,
    required File file,
    String bucket = matchUpBucket,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final fileExt = file.path.split('.').last;

      await _supabase.storage.from(bucket).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(
              upsert: true, // Overwrite existing file
              contentType: _getContentType(fileExt),
            ),
          );
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } catch (e) {
      throw Exception('Failed to update image: $e');
    }
  }

  /// Get content type based on file extension
  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      default:
        return 'image/jpeg';
    }
  }
}
