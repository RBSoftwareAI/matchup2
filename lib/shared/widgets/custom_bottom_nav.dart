import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/colors.dart';

/// Custom bottom navigation bar
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                icon: Icons.home,
                label: 'Accueil',
                index: 0,
                route: '/home',
              ),
              _buildNavItem(
                context: context,
                icon: Icons.local_fire_department,
                label: 'Matchs',
                index: 1,
                route: '/matches',
              ),
              _buildNavItem(
                context: context,
                icon: Icons.chat_bubble_outline,
                label: 'Chat',
                index: 2,
                route: '/chat',
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person,
                label: 'Profil',
                index: 3,
                route: '/profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build navigation item
  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required String route,
  }) {
    final isSelected = currentIndex == index;
    
    return InkWell(
      onTap: () {
        if (!isSelected) {
          context.go(route);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
