/// Message model for chat
class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  const Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  /// Check if message is sent by current user
  bool isSentByMe(String currentUserId) {
    return senderId == currentUserId;
  }

  /// Copy with method
  Message copyWith({
    String? id,
    String? senderId,
    String? senderName,
    String? receiverId,
    String? content,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}

/// Conversation model for chat list
class Conversation {
  final String id;
  final String userId;
  final String userName;
  final String userPhotoUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const Conversation({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });
}
