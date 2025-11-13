import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../../domain/models/profile.dart';

/// Profile card widget for the swipeable deck
class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Profile photo
            _buildPhoto(),
            // Gradient overlay
            _buildGradientOverlay(),
            // Profile info
            _buildProfileInfo(),
          ],
        ),
      ),
    );
  }

  /// Build profile photo
  Widget _buildPhoto() {
    return Positioned.fill(
      child: CachedNetworkImage(
        imageUrl: profile.photoUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.border,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.border,
          child: const Icon(
            Icons.person,
            size: 100,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }

  /// Build gradient overlay for better text visibility
  Widget _buildGradientOverlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.8),
            ],
          ),
        ),
      ),
    );
  }

  /// Build profile information section
  Widget _buildProfileInfo() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name and age
          Row(
            children: [
              Text(
                profile.name,
                style: AppTextStyles.h2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${profile.age}',
                style: AppTextStyles.h2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Job title
          Text(
            profile.jobTitle,
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Distance
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                '${profile.distanceKm.toStringAsFixed(1)} km',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Interests (max 5)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: profile.interests
                .take(5)
                .map((interest) => _buildInterestChip(interest))
                .toList(),
          ),
        ],
      ),
    );
  }

  /// Build interest chip
  Widget _buildInterestChip(String interest) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        interest,
        style: AppTextStyles.bodySmall.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
