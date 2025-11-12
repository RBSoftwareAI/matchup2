import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

/// Swipe action buttons widget
class SwipeButtons extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onLike;
  final VoidCallback onSuperLike;

  const SwipeButtons({
    super.key,
    required this.onDislike,
    required this.onLike,
    required this.onSuperLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Dislike button
        _buildActionButton(
          icon: Icons.close,
          color: Colors.red,
          size: 60,
          iconSize: 32,
          onPressed: onDislike,
        ),
        // Like button
        _buildActionButton(
          icon: Icons.favorite,
          color: AppColors.primary,
          size: 70,
          iconSize: 36,
          onPressed: onLike,
        ),
        // Super like button
        _buildActionButton(
          icon: Icons.local_fire_department,
          color: Colors.orange,
          size: 60,
          iconSize: 32,
          onPressed: onSuperLike,
        ),
      ],
    );
  }

  /// Build action button
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required double iconSize,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white,
      elevation: 8,
      shadowColor: color.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
