import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/models/profile.dart';
import 'profile_card.dart';

/// Profile deck widget with swipeable cards
class ProfileDeck extends StatefulWidget {
  final List<Profile> profiles;
  final Function(Profile) onSwipeLeft;
  final Function(Profile) onSwipeRight;
  final Function(Profile) onSwipeUp;

  const ProfileDeck({
    super.key,
    required this.profiles,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSwipeUp,
  });

  @override
  State<ProfileDeck> createState() => _ProfileDeckState();
}

class _ProfileDeckState extends State<ProfileDeck> {
  final CardSwiperController _controller = CardSwiperController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.profiles.isEmpty) {
      return _buildEmptyState();
    }

    return CardSwiper(
      controller: _controller,
      cardsCount: widget.profiles.length,
      numberOfCardsDisplayed: 3,
      backCardOffset: const Offset(0, -20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      duration: const Duration(milliseconds: 300),
      maxAngle: 30,
      threshold: 50,
      scale: 0.9,
      isLoop: false,
      onSwipe: _onSwipe,
      cardBuilder: (context, index, horizontalThreshold, verticalThreshold) {
        final profile = widget.profiles[index];
        return ProfileCard(profile: profile);
      },
    );
  }

  /// Handle swipe callback
  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final profile = widget.profiles[previousIndex];

    switch (direction) {
      case CardSwiperDirection.left:
        widget.onSwipeLeft(profile);
        _showFeedback('Profil refusé', Icons.close, Colors.red);
        break;
      case CardSwiperDirection.right:
        widget.onSwipeRight(profile);
        _showFeedback('Like ! ❤️', Icons.favorite, AppColors.primary);
        break;
      case CardSwiperDirection.top:
        widget.onSwipeUp(profile);
        _showFeedback('Super Like ! 🔥', Icons.local_fire_department, Colors.orange);
        break;
      case CardSwiperDirection.bottom:
        // Not used
        break;
      default:
        break;
    }
    return true;
  }

  /// Show feedback snackbar
  void _showFeedback(String message, IconData icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(message, style: const TextStyle(fontSize: 16)),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Build empty state when no profiles
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Plus de profils pour l\'instant',
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Revenez plus tard pour découvrir\nde nouveaux profils',
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
