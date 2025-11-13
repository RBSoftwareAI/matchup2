import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/models/message.dart';
import '../widgets/conversation_card.dart';

/// Chat list screen showing all conversations
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock conversations
  final List<Conversation> _conversations = [
    Conversation(
      id: '1',
      userId: '1',
      userName: 'Sophie',
      userPhotoUrl: 'https://i.pravatar.cc/400?img=1',
      lastMessage: 'Salut ! Comment ça va ?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      unreadCount: 2,
    ),
    Conversation(
      id: '2',
      userId: '2',
      userName: 'Lucas',
      userPhotoUrl: 'https://i.pravatar.cc/400?img=12',
      lastMessage: 'On se voit ce week-end ?',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 0,
    ),
    Conversation(
      id: '3',
      userId: '3',
      userName: 'Léa',
      userPhotoUrl: 'https://i.pravatar.cc/400?img=5',
      lastMessage: 'Merci pour la recommandation !',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
    ),
    Conversation(
      id: '4',
      userId: '5',
      userName: 'Emma',
      userPhotoUrl: 'https://i.pravatar.cc/400?img=9',
      lastMessage: 'J\'adore ce restaurant aussi !',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 2)),
      unreadCount: 0,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Search bar
            _buildSearchBar(),
            // Conversations list
            Expanded(
              child: _buildConversationsList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Messages',
            style: AppTextStyles.h1,
          ),
          // Unread count badge
          if (_conversations.any((c) => c.unreadCount > 0))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_conversations.fold<int>(0, (sum, c) => sum + c.unreadCount)}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher une conversation...',
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textMuted,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  /// Build conversations list
  Widget _buildConversationsList() {
    if (_conversations.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      itemCount: _conversations.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: AppColors.border,
        indent: 92,
      ),
      itemBuilder: (context, index) {
        final conversation = _conversations[index];
        return ConversationCard(
          conversation: conversation,
          onTap: () {
            context.push('/chat/${conversation.userId}', extra: {
              'userName': conversation.userName,
              'userPhotoUrl': conversation.userPhotoUrl,
            });
          },
        );
      },
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 100,
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Aucune conversation',
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Commencez à matcher pour\nentamer des conversations',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
