import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/models/message.dart';
import '../widgets/chat_bubble.dart';

/// Chat detail screen for individual conversation
class ChatDetailScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userPhotoUrl;

  const ChatDetailScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final String _currentUserId = 'current_user';

  // Mock messages
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMockMessages();
  }

  void _loadMockMessages() {
    _messages.addAll([
      Message(
        id: '1',
        senderId: widget.userId,
        senderName: widget.userName,
        receiverId: _currentUserId,
        content: 'Salut ! Comment ça va ?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        isRead: true,
      ),
      Message(
        id: '2',
        senderId: _currentUserId,
        senderName: 'Moi',
        receiverId: widget.userId,
        content: 'Salut ! Ça va super et toi ?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
        isRead: true,
      ),
      Message(
        id: '3',
        senderId: widget.userId,
        senderName: widget.userName,
        receiverId: _currentUserId,
        content: 'Très bien merci ! Tu es libre ce week-end ?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: true,
      ),
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: _buildMessagesList(),
          ),
          // Input field
          _buildMessageInput(),
        ],
      ),
    );
  }

  /// Build app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.userPhotoUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.border,
                  child: const Icon(Icons.person, size: 20),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.border,
                  child: const Icon(Icons.person, size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'En ligne',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build messages list
  Widget _buildMessagesList() {
    if (_messages.isEmpty) {
      return Center(
        child: Text(
          'Aucun message pour l\'instant\nCommencez la conversation !',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isSentByMe = message.isSentByMe(_currentUserId);
        return ChatBubble(
          message: message,
          isSentByMe: isSentByMe,
        );
      },
    );
  }

  /// Build message input
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Text field
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Écrivez un message...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMuted,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(width: 12),
            // Send button
            Material(
              color: AppColors.primary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: _sendMessage,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Send message
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: _currentUserId,
          senderName: 'Moi',
          receiverId: widget.userId,
          content: _messageController.text.trim(),
          timestamp: DateTime.now(),
          isRead: false,
        ),
      );
    });

    _messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
