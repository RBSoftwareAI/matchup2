import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Profile header widget with avatar and user info
class ProfileHeader extends StatelessWidget {
  final String photoUrl;
  final String name;
  final int age;
  final String city;
  final String country;
  final VoidCallback onEditPhoto;
  final VoidCallback onEditProfile;

  const ProfileHeader({
    super.key,
    required this.photoUrl,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.onEditPhoto,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Avatar with edit icon
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: CachedNetworkImageProvider(photoUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditPhoto,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.cardBackground,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Name and Age
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: AppTextStyles.h2,
              ),
              const SizedBox(width: 6),
              Text(
                '$age',
                style: AppTextStyles.h2,
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          // Location
          Text(
            '$city, $country',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          
          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onEditProfile,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Modifier le profil'),
            ),
          ),
        ],
      ),
    );
  }
}
