import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../providers/matches_provider.dart';
import '../widgets/match_request_card.dart';

/// Matches screen with pending requests and confirmed matches
class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  'Matchs',
                  style: AppTextStyles.h1,
                ),
              ),
              
              // TabBar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.textMuted,
                  labelStyle: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: const [
                    Tab(text: 'Demandes'),
                    Tab(text: 'Confirmés'),
                  ],
                ),
              ),
              
              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    _RequestsTab(),
                    _ConfirmedTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tab for pending match requests
class _RequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MatchesProvider>(
      builder: (context, provider, child) {
        final requests = provider.requests;
        
        if (requests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 80,
                  color: AppColors.textMuted.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Aucune demande pour l\'instant',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return MatchRequestCard(
              request: request,
              onAccept: () {
                provider.acceptRequest(request);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Match avec ${request.name} accepté !'),
                    backgroundColor: AppColors.success,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              onDecline: () {
                provider.declineRequest(request);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Demande refusée'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

/// Tab for confirmed matches
class _ConfirmedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MatchesProvider>(
      builder: (context, provider, child) {
        final confirmedMatches = provider.confirmedMatches;
        
        if (confirmedMatches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: AppColors.textMuted.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Aucun match confirmé',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Acceptez des demandes pour commencer\nà discuter',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: confirmedMatches.length,
          itemBuilder: (context, index) {
            final match = confirmedMatches[index];
            final userId = match['userId'] as String;
            final userName = match['userName'] as String;
            final userPhotoUrl = match['userPhotoUrl'] as String;
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: CachedNetworkImageProvider(userPhotoUrl),
                ),
                title: Text(
                  userName,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Match confirmé',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.success,
                  ),
                ),
                trailing: Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.primary,
                ),
                onTap: () {
                  // Navigate to chat
                  context.push(
                    '/chat/$userId',
                    extra: {
                      'userName': userName,
                      'userPhotoUrl': userPhotoUrl,
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
