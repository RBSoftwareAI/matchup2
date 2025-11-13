/// User Service
/// 
/// Handles all user profile operations with Supabase database
/// - Get user profile
/// - Update user profile
/// - Search users
/// - Get user gallery
/// - Get user interests
library;

import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class UserService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  /// Get user profile by ID
  /// 
  /// Returns complete user profile data
  /// Throws PostgrestException on failure
  /// 
  /// Example:
  /// ```dart
  /// final profile = await userService.getUserProfile('user-uuid');
  /// print('Name: ${profile['username']}');
  /// print('Bio: ${profile['bio']}');
  /// ```
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      return response;
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Get current user's profile
  /// 
  /// Returns current authenticated user's profile
  /// 
  /// Example:
  /// ```dart
  /// final myProfile = await userService.getCurrentUserProfile();
  /// ```
  Future<Map<String, dynamic>> getCurrentUserProfile() async {
    final userId = SupabaseConfig.userId;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    return getUserProfile(userId);
  }

  /// Update user profile
  /// 
  /// Updates user profile with new data
  /// Only updates provided fields
  /// 
  /// Example:
  /// ```dart
  /// await userService.updateUserProfile(
  ///   userId: 'user-uuid',
  ///   data: {
  ///     'username': 'new_username',
  ///     'bio': 'My new bio',
  ///     'city': 'Paris',
  ///   },
  /// );
  /// ```
  Future<void> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _supabase.from('users').update(data).eq('id', userId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Create new user profile
  /// 
  /// Creates a new user profile after authentication
  /// Called automatically after sign up
  /// 
  /// Example:
  /// ```dart
  /// await userService.createUserProfile(
  ///   userId: authResponse.user!.id,
  ///   username: 'johndoe',
  ///   email: 'john@example.com',
  ///   gender: 'male',
  /// );
  /// ```
  Future<void> createUserProfile({
    required String userId,
    required String username,
    required String email,
    String? gender,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final data = {
        'id': userId,
        'username': username,
        'email': email,
        if (gender != null) 'gender': gender,
        ...?additionalData,
      };

      await _supabase.from('users').insert(data);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Search users by filters
  /// 
  /// Search users with optional filters (gender, age, city)
  /// Returns list of user profiles
  /// 
  /// Example:
  /// ```dart
  /// final users = await userService.searchUsers(
  ///   gender: 'female',
  ///   minAge: 25,
  ///   maxAge: 35,
  ///   city: 'Paris',
  ///   limit: 20,
  /// );
  /// ```
  Future<List<Map<String, dynamic>>> searchUsers({
    String? gender,
    int? minAge,
    int? maxAge,
    String? city,
    int limit = 50,
  }) async {
    try {
      var query = _supabase.from('users').select();

      // Apply filters
      if (gender != null) {
        query = query.eq('gender', gender);
      }
      if (minAge != null) {
        query = query.gte('age', minAge);
      }
      if (maxAge != null) {
        query = query.lte('age', maxAge);
      }
      if (city != null) {
        query = query.eq('city', city);
      }

      // Apply limit and active users only
      final response = await query.eq('is_active', true).limit(limit);
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  /// Get user gallery photos
  /// 
  /// Returns all photos for a user
  /// 
  /// Example:
  /// ```dart
  /// final photos = await userService.getUserGallery('user-uuid');
  /// for (var photo in photos) {
  ///   print('Photo URL: ${photo['image']}');
  /// }
  /// ```
  Future<List<Map<String, dynamic>>> getUserGallery(String userId) async {
    try {
      final response = await _supabase
          .from('gallery')
          .select()
          .eq('users_id', userId)
          .order('position');

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get user gallery: $e');
    }
  }

  /// Get user interests
  /// 
  /// Returns all interests/hobbies for a user
  /// 
  /// Example:
  /// ```dart
  /// final interests = await userService.getUserInterests('user-uuid');
  /// for (var interest in interests) {
  ///   print('Interest: ${interest['name']}');
  /// }
  /// ```
  Future<List<Map<String, dynamic>>> getUserInterests(String userId) async {
    try {
      final response = await _supabase
          .from('interest')
          .select()
          .eq('users_id', userId);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get user interests: $e');
    }
  }

  /// Add interest to user
  /// 
  /// Adds a new interest/hobby to user profile
  /// 
  /// Example:
  /// ```dart
  /// await userService.addInterest('user-uuid', 'Photography');
  /// ```
  Future<void> addInterest(String userId, String interestName) async {
    try {
      await _supabase.from('interest').insert({
        'users_id': userId,
        'name': interestName,
      });
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to add interest: $e');
    }
  }

  /// Remove interest from user
  /// 
  /// Removes an interest/hobby from user profile
  /// 
  /// Example:
  /// ```dart
  /// await userService.removeInterest(interestId);
  /// ```
  Future<void> removeInterest(int interestId) async {
    try {
      await _supabase.from('interest').delete().eq('id', interestId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to remove interest: $e');
    }
  }

  /// Update last active timestamp
  /// 
  /// Updates user's last_active field to current time
  /// 
  /// Example:
  /// ```dart
  /// await userService.updateLastActive('user-uuid');
  /// ```
  Future<void> updateLastActive(String userId) async {
    try {
      await _supabase.from('users').update({
        'last_active': DateTime.now().toIso8601String(),
      }).eq('id', userId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to update last active: $e');
    }
  }
}
