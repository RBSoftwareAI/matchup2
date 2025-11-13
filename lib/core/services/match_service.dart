/// Match Service
/// 
/// Handles all matching operations with Supabase database
/// - Send match requests (like someone)
/// - Accept/reject match requests
/// - Get matches
/// - Get match requests
library;

import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class MatchService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  /// Send match request (like someone)
  /// 
  /// Creates a new match request from current user to target user
  /// 
  /// Example:
  /// ```dart
  /// await matchService.sendMatchRequest('target-user-uuid');
  /// ```
  Future<void> sendMatchRequest(String targetUserId) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _supabase.from('matches').insert({
        'sender_match': currentUserId,
        'receiver_match': targetUserId,
        'accepted': null, // Pending
      });
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to send match request: $e');
    }
  }

  /// Accept match request
  /// 
  /// Accepts a match request by setting accepted to true
  /// Creates a mutual match
  /// 
  /// Example:
  /// ```dart
  /// await matchService.acceptMatchRequest(matchId);
  /// ```
  Future<void> acceptMatchRequest(int matchId) async {
    try {
      await _supabase.from('matches').update({
        'accepted': true,
      }).eq('id', matchId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to accept match request: $e');
    }
  }

  /// Reject match request
  /// 
  /// Rejects a match request by setting accepted to false
  /// 
  /// Example:
  /// ```dart
  /// await matchService.rejectMatchRequest(matchId);
  /// ```
  Future<void> rejectMatchRequest(int matchId) async {
    try {
      await _supabase.from('matches').update({
        'accepted': false,
      }).eq('id', matchId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to reject match request: $e');
    }
  }

  /// Get received match requests (pending)
  /// 
  /// Returns all pending match requests received by current user
  /// Includes sender user data
  /// 
  /// Example:
  /// ```dart
  /// final requests = await matchService.getReceivedMatchRequests();
  /// for (var request in requests) {
  ///   print('From: ${request['sender_profile']['username']}');
  /// }
  /// ```
  Future<List<Map<String, dynamic>>> getReceivedMatchRequests() async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase
          .from('matches')
          .select('''
            *,
            sender_profile:sender_match (
              id, username, email, image, age, city, bio
            )
          ''')
          .eq('receiver_match', currentUserId)
          .isFilter('accepted', null) // Only pending requests
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get match requests: $e');
    }
  }

  /// Get sent match requests
  /// 
  /// Returns all match requests sent by current user
  /// Includes receiver user data
  /// 
  /// Example:
  /// ```dart
  /// final requests = await matchService.getSentMatchRequests();
  /// ```
  Future<List<Map<String, dynamic>>> getSentMatchRequests() async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase
          .from('matches')
          .select('''
            *,
            receiver_profile:receiver_match (
              id, username, email, image, age, city, bio
            )
          ''')
          .eq('sender_match', currentUserId)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get sent match requests: $e');
    }
  }

  /// Get confirmed matches
  /// 
  /// Returns all confirmed matches for current user
  /// Includes match user data
  /// 
  /// Example:
  /// ```dart
  /// final matches = await matchService.getConfirmedMatches();
  /// for (var match in matches) {
  ///   print('Matched with: ${match['match_profile']['username']}');
  /// }
  /// ```
  Future<List<Map<String, dynamic>>> getConfirmedMatches() async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Get matches where current user is sender
      final sentMatches = await _supabase
          .from('matches')
          .select('''
            *,
            match_profile:receiver_match (
              id, username, email, image, age, city, bio
            )
          ''')
          .eq('sender_match', currentUserId)
          .eq('accepted', true);

      // Get matches where current user is receiver
      final receivedMatches = await _supabase
          .from('matches')
          .select('''
            *,
            match_profile:sender_match (
              id, username, email, image, age, city, bio
            )
          ''')
          .eq('receiver_match', currentUserId)
          .eq('accepted', true);

      // Combine both lists
      final allMatches = [
        ...List<Map<String, dynamic>>.from(sentMatches),
        ...List<Map<String, dynamic>>.from(receivedMatches),
      ];

      // Sort by created_at
      allMatches.sort((a, b) {
        final aDate = DateTime.parse(a['created_at']);
        final bDate = DateTime.parse(b['created_at']);
        return bDate.compareTo(aDate);
      });

      return allMatches;
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get confirmed matches: $e');
    }
  }

  /// Check if match exists between two users
  /// 
  /// Returns true if match exists (any status), false otherwise
  /// 
  /// Example:
  /// ```dart
  /// final exists = await matchService.matchExists('other-user-uuid');
  /// if (exists) {
  ///   print('Match already exists');
  /// }
  /// ```
  Future<bool> matchExists(String otherUserId) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase
          .from('matches')
          .select()
          .or(
            'and(sender_match.eq.$currentUserId,receiver_match.eq.$otherUserId),and(sender_match.eq.$otherUserId,receiver_match.eq.$currentUserId)',
          )
          .limit(1);

      return response.isNotEmpty;
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to check match exists: $e');
    }
  }

  /// Check if users are matched
  /// 
  /// Returns true if match is confirmed (accepted = true), false otherwise
  /// 
  /// Example:
  /// ```dart
  /// final matched = await matchService.areUsersMatched('other-user-uuid');
  /// if (matched) {
  ///   // Can start conversation
  /// }
  /// ```
  Future<bool> areUsersMatched(String otherUserId) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase
          .from('matches')
          .select()
          .eq('accepted', true)
          .or(
            'and(sender_match.eq.$currentUserId,receiver_match.eq.$otherUserId),and(sender_match.eq.$otherUserId,receiver_match.eq.$currentUserId)',
          )
          .limit(1);

      return response.isNotEmpty;
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to check if users are matched: $e');
    }
  }

  /// Unmatch users (delete match)
  /// 
  /// Deletes the match between two users
  /// 
  /// Example:
  /// ```dart
  /// await matchService.unmatch('other-user-uuid');
  /// ```
  Future<void> unmatch(String otherUserId) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _supabase.from('matches').delete().or(
            'and(sender_match.eq.$currentUserId,receiver_match.eq.$otherUserId),and(sender_match.eq.$otherUserId,receiver_match.eq.$currentUserId)',
          );
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to unmatch: $e');
    }
  }
}
