import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/photo_grid.dart';
import '../widgets/interest_chip.dart';

/// Profile screen displaying user profile and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            final profile = provider.profile;
            
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Text(
                      'Profil',
                      style: AppTextStyles.h1,
                    ),
                  ),
                  
                  // Profile Header (Avatar, Name, Location, Edit Button)
                  ProfileHeader(
                    photoUrl: profile.mainPhotoUrl,
                    name: profile.name,
                    age: profile.age,
                    city: profile.city,
                    country: profile.country,
                    onEditPhoto: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Modification photo à venir'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    onEditProfile: () {
                      context.push('/edit-profile');
                    },
                  ),
                  
                  // Content cards
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Information Card
                        ProfileInfoCard(
                          title: 'Informations',
                          children: [
                            InfoRow(
                              icon: Icons.article_outlined,
                              label: 'Bio',
                              value: profile.bio,
                            ),
                            if (profile.jobTitle != null)
                              InfoRow(
                                icon: Icons.work_outline,
                                label: 'Métier',
                                value: profile.jobTitle!,
                              ),
                            if (profile.company != null)
                              InfoRow(
                                icon: Icons.business_outlined,
                                label: 'Entreprise',
                                value: profile.company!,
                              ),
                            if (profile.education != null)
                              InfoRow(
                                icon: Icons.school_outlined,
                                label: 'Éducation',
                                value: profile.education!,
                              ),
                            if (profile.heightCm != null)
                              InfoRow(
                                icon: Icons.height,
                                label: 'Taille',
                                value: '${profile.heightCm} cm',
                              ),
                          ],
                        ),
                        
                        // Photos Card
                        ProfileInfoCard(
                          title: 'Photos',
                          children: [
                            PhotoGrid(
                              photoUrls: profile.photoUrls,
                              onAddPhoto: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Ajout de photos à venir'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        
                        // Interests Card
                        ProfileInfoCard(
                          title: 'Centres d\'intérêt',
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: profile.interests
                                  .map((interest) => InterestChip(
                                        label: interest,
                                        isSelected: true,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                        
                        // Preferences Card (read-only)
                        ProfileInfoCard(
                          title: 'Préférences',
                          children: [
                            InfoRow(
                              icon: Icons.favorite_outline,
                              label: 'Genres préférés',
                              value: profile.preferences.preferredGenders.join(', '),
                            ),
                            InfoRow(
                              icon: Icons.calendar_today,
                              label: 'Tranche d\'âge',
                              value: '${profile.preferences.minAge} - ${profile.preferences.maxAge} ans',
                            ),
                            InfoRow(
                              icon: Icons.location_on_outlined,
                              label: 'Distance maximale',
                              value: '${profile.preferences.maxDistanceKm} km',
                            ),
                          ],
                        ),
                        
                        // Settings & More Section
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Paramètres & plus',
                                style: AppTextStyles.h3,
                              ),
                              const SizedBox(height: 12),
                              _SettingsListTile(
                                icon: Icons.edit_outlined,
                                title: 'Éditer le profil',
                                onTap: () => context.push('/edit-profile'),
                              ),
                              _SettingsListTile(
                                icon: Icons.privacy_tip_outlined,
                                title: 'Confidentialité',
                                onTap: () => context.push('/privacy'),
                              ),
                              _SettingsListTile(
                                icon: Icons.notifications_outlined,
                                title: 'Notifications',
                                onTap: () => context.push('/notifications-settings'),
                              ),
                              _SettingsListTile(
                                icon: Icons.security_outlined,
                                title: 'Compte & sécurité',
                                onTap: () => context.push('/account'),
                              ),
                              _SettingsListTile(
                                icon: Icons.help_outline,
                                title: 'Aide',
                                onTap: () => context.push('/help'),
                              ),
                              _SettingsListTile(
                                icon: Icons.gavel_outlined,
                                title: 'Mentions légales',
                                onTap: () => context.push('/legal'),
                                showDivider: false,
                              ),
                            ],
                          ),
                        ),
                        
                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _showLogoutDialog(context);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.error,
                              side: BorderSide(color: AppColors.error),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: const Icon(Icons.logout),
                            label: const Text('Déconnexion'),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/start');
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}

/// Settings list tile widget
class _SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const _SettingsListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.border,
          ),
      ],
    );
  }
}
