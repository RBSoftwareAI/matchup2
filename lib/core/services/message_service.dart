/// Message Service
/// 
/// Handles all messaging operations with Supabase database
/// - Send messages
/// - Get conversations
/// - Get messages
/// - Mark messages as seen
/// - Real-time message updates
library;

import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class MessageService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  /// Send a message to another user
  /// 
  /// Creates a new message in the database
  /// Only works if users are matched
  /// 
  /// Example:
  /// ```dart
  /// await messageService.sendMessage(
  ///   recipientId: 'recipient-user-uuid',
  ///   message: 'Hello! How are you?',
  /// );
  /// ```
  Future<Map<String, dynamic>> sendMessage({
    required String recipientId,
    required String message,
  }) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase.from('message').insert({
        'sender_id': currentUserId,
        'destination_users': recipientId,
        'message': message,
        'seen': false,
      }).select().single();

      return response;
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  /// Get conversations list
  /// 
  /// Returns list of unique conversations with last message
  /// Sorted by latest message first
  /// 
  /// Example:
  /// ```dart
  /// final conversations = await messageService.getConversations();
  /// for (var conv in conversations) {
  ///   print('${conv['username']}: ${conv['last_message']}');
  /// }
  /// ```
  Future<List<Map<String, dynamic>>> getConversations() async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Get all messages where user is sender or receiver
      final messages = await _supabase
          .from('message')
          .select('''
            *,
            sender:sender_id (id, username, image),
            recipient:destination_users (id, username, image)
          ''')
          .or('sender_id.eq.$currentUserId,destination_users.eq.$currentUserId')
          .order('created_at', ascending: false);

      // Group by conversation partner and get last message
      final Map<String, Map<String, dynamic>> conversationsMap = {};

      for (var message in messages) {
        final senderId = message['sender_id'];
        final recipientId = message['destination_users'];

        // Determine conversation partner
        final partnerId =
            senderId == currentUserId ? recipientId : senderId;

        // If not yet in map or this message is newer
        if (!conversationsMap.containsKey(partnerId)) {
          conversationsMap[partnerId] = {
            'partner_id': partnerId,
            'partner_username':
                senderId == currentUserId
                    ? message['recipient']['username']
                    : message['sender']['username'],
            'partner_image':
                senderId == currentUserId
                    ? message['recipient']['image']
                    : message['sender']['image'],
            'last_message': message['message'],
            'last_message_time': message['created_at'],
            'unread_count': 0,
          };
        }

        // Count unread messages from partner
        if (message['destination_users'] == currentUserId &&
            message['seen'] == false) {
          conversationsMap[partnerId]!['unread_count'] =
              (conversationsMap[partnerId]!['unread_count'] as int) + 1;
        }
      }

      return conversationsMap.values.toList();
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  /// Get messages between current user and another user
  /// 
  /// Returns all messages in a conversation
  /// Sorted by creation time (oldest first)
  /// 
  /// Example:
  /// ```dart
  /// final messages = await messageService.getMessages('other-user-uuid');
  /// for (var msg in messages) {
  ///   print('${msg['created_at']}: ${msg['message']}');
  /// }
  /// ```
  Future<List<Map<String, dynamic>>> getMessages(String otherUserId) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase
          .from('message')
          .select('''
            *,
            sender:sender_id (id, username, image),
            recipient:destination_users (id, username, image)
          ''')
          .or(
            'and(sender_id.eq.$currentUserId,destination_users.eq.$otherUserId),and(sender_id.eq.$otherUserId,destination_users.eq.$currentUserId)',
          )
          .order('created_at', ascending: true);

      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  /// Mark messages as seen
  /// 
  /// Marks all messages from a specific user as seen
  /// 
  /// Example:
  /// ```dart
  /// await messageService.markMessagesAsSeen('sender-user-uuid');
  /// ```
  Future<void> markMessagesAsSeen(String senderId) async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      await _supabase
          .from('message')
          .update({'seen': true})
          .eq('sender_id', senderId)
          .eq('destination_users', currentUserId)
          .eq('seen', false);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to mark messages as seen: $e');
    }
  }

  /// Mark specific message as seen
  /// 
  /// Marks a single message as seen by ID
  /// 
  /// Example:
  /// ```dart
  /// await messageService.markMessageAsSeen(messageId);
  /// ```
  Future<void> markMessageAsSeen(int messageId) async {
    try {
      await _supabase
          .from('message')
          .update({'seen': true})
          .eq('id', messageId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to mark message as seen: $e');
    }
  }

  /// Get unread message count
  /// 
  /// Returns total number of unread messages for current user
  /// 
  /// Example:
  /// ```dart
  /// final count = await messageService.getUnreadCount();
  /// print('You have $count unread messages');
  /// ```
  Future<int> getUnreadCount() async {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await _supabase
          .from('message')
          .select('id')
          .eq('destination_users', currentUserId)
          .eq('seen', false)
          .count();

      return response.count;
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }

  /// Delete a message
  /// 
  /// Deletes a message by ID
  /// Only the sender can delete their messages
  /// 
  /// Example:
  /// ```dart
  /// await messageService.deleteMessage(messageId);
  /// ```
  Future<void> deleteMessage(int messageId) async {
    try {
      await _supabase.from('message').delete().eq('id', messageId);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.message);
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  /// Subscribe to new messages in a conversation
  /// 
  /// Returns a stream of new messages in real-time
  /// 
  /// Example:
  /// ```dart
  /// final stream = messageService.subscribeToMessages('other-user-uuid');
  /// stream.listen((message) {
  ///   print('New message: ${message['message']}');
  /// });
  /// ```
  Stream<List<Map<String, dynamic>>> subscribeToMessages(String otherUserId) {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    return _supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .order('created_at');
  }

  /// Subscribe to all messages for current user
  /// 
  /// Returns a stream of all messages where user is sender or receiver
  /// Useful for updating conversation list in real-time
  /// 
  /// Example:
  /// ```dart
  /// final stream = messageService.subscribeToAllMessages();
  /// stream.listen((messages) {
  ///   print('Messages updated: ${messages.length} total');
  /// });
  /// ```
  Stream<List<Map<String, dynamic>>> subscribeToAllMessages() {
    final currentUserId = SupabaseConfig.userId;
    if (currentUserId == null) {
      throw Exception('User not authenticated');
    }

    return _supabase
        .from('message')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);
  }
}
