import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

/// Legal information screen
class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Mentions légales'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Legal Documents Section
            SettingsSection(
              title: 'Documents légaux',
              children: [
                SettingsTile(
                  icon: Icons.article_outlined,
                  title: 'Conditions générales d\'utilisation',
                  onTap: () => context.push('/terms-of-service'),
                ),
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Politique de confidentialité',
                  onTap: () => context.push('/privacy-policy'),
                ),
                SettingsTile(
                  icon: Icons.cookie_outlined,
                  title: 'Politique des cookies',
                  onTap: () => context.push('/cookie-policy'),
                ),
                SettingsTile(
                  icon: Icons.groups_outlined,
                  title: 'Règles de la communauté',
                  onTap: () => context.push('/community-guidelines'),
                  showDivider: false,
                ),
              ],
            ),

            // Company Information Section
            SettingsSection(
              title: 'Informations légales',
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'MatchUp - Application de rencontre',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Éditeur', 'MatchUp SAS'),
                _buildInfoRow('Adresse', '123 Rue de l\'Innovation\n75001 Paris, France'),
                _buildInfoRow('SIRET', '123 456 789 00012'),
                _buildInfoRow('Capital social', '10 000 €'),
                const SizedBox(height: 16),
                _buildInfoRow('Directeur de la publication', '[Nom]'),
                const SizedBox(height: 16),
                Text(
                  'Hébergement',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Hébergeur', '[Nom de l\'hébergeur]'),
                _buildInfoRow('Adresse', '[Adresse]'),
                const SizedBox(height: 16),
                Text(
                  'Contact',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Email', 'contact@matchup.com'),
                _buildInfoRow('Téléphone', '+33 1 23 45 67 89'),
              ],
            ),

            // Open Source Licenses Section
            SettingsSection(
              title: 'Licences open source',
              children: [
                SettingsTile(
                  icon: Icons.code,
                  title: 'Licences des bibliothèques',
                  subtitle: 'Flutter et packages tiers',
                  onTap: () => _showLicensesDialog(context),
                  showDivider: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _showLicensesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Licences des bibliothèques'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildLicenseTile('Flutter SDK', 'BSD-3-Clause License'),
              _buildLicenseTile('provider', 'MIT License'),
              _buildLicenseTile('go_router', 'BSD-3-Clause License'),
              _buildLicenseTile('cached_network_image', 'MIT License'),
              _buildLicenseTile('flutter_card_swiper', 'MIT License'),
              _buildLicenseTile('intl', 'BSD-3-Clause License'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseTile(String name, String license) {
    return ListTile(
      title: Text(name),
      subtitle: Text(
        license,
        style: TextStyle(color: AppColors.textMuted),
      ),
      dense: true,
    );
  }
}
