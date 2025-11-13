import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/settings_section.dart';
import '../widgets/custom_switch_tile.dart';
import '../widgets/settings_tile.dart';
import '../providers/settings_provider.dart';

/// Privacy settings screen
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Confidentialité'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Visibility Section
                SettingsSection(
                  title: 'Visibilité du profil',
                  children: [
                    CustomSwitchTile(
                      title: 'Rendre mon profil visible',
                      subtitle: 'Désactiver pour masquer votre profil des autres utilisateurs',
                      value: settings.isProfileVisible,
                      onChanged: (value) {
                        settings.setProfileVisible(value);
                        _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Who Can See Me Section
                SettingsSection(
                  title: 'Qui peut me voir',
                  children: [
                    RadioListTile<String>(
                      title: const Text('Tout le monde'),
                      value: 'Tout le monde',
                      groupValue: settings.whoCanSeeMe,
                      onChanged: (value) {
                        if (value != null) {
                          settings.setWhoCanSeeMe(value);
                          _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                        }
                      },
                      activeColor: AppColors.primary,
                    ),
                    RadioListTile<String>(
                      title: const Text('Seulement mes matchs'),
                      value: 'Seulement mes matchs',
                      groupValue: settings.whoCanSeeMe,
                      onChanged: (value) {
                        if (value != null) {
                          settings.setWhoCanSeeMe(value);
                          _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                        }
                      },
                      activeColor: AppColors.primary,
                    ),
                    RadioListTile<String>(
                      title: const Text('Personne'),
                      value: 'Personne',
                      groupValue: settings.whoCanSeeMe,
                      onChanged: (value) {
                        if (value != null) {
                          settings.setWhoCanSeeMe(value);
                          _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                        }
                      },
                      activeColor: AppColors.primary,
                    ),
                  ],
                ),

                // Location Section
                SettingsSection(
                  title: 'Localisation',
                  children: [
                    CustomSwitchTile(
                      title: 'Afficher ma position',
                      subtitle: 'Permet aux autres de voir votre distance approximative',
                      value: settings.showLocation,
                      onChanged: (value) {
                        settings.setShowLocation(value);
                        _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                      },
                    ),
                    CustomSwitchTile(
                      title: 'Partager ma localisation précise',
                      subtitle: 'Affiche votre ville et pays sur votre profil',
                      value: settings.sharePreciseLocation,
                      onChanged: (value) {
                        settings.setSharePreciseLocation(value);
                        _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Online Activity Section
                SettingsSection(
                  title: 'Activité en ligne',
                  children: [
                    CustomSwitchTile(
                      title: 'Afficher mon statut en ligne',
                      subtitle: 'Les autres peuvent voir quand vous êtes connecté',
                      value: settings.showOnlineStatus,
                      onChanged: (value) {
                        settings.setShowOnlineStatus(value);
                        _showSnackBar(context, 'Paramètres de confidentialité mis à jour (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Blocking Section
                SettingsSection(
                  title: 'Blocage et signalement',
                  children: [
                    SettingsTile(
                      icon: Icons.block,
                      title: 'Utilisateurs bloqués',
                      subtitle: 'Aucun utilisateur bloqué',
                      onTap: () {
                        _showSnackBar(context, 'Liste vide (placeholder)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Data Download Section
                SettingsSection(
                  title: 'Données et téléchargement',
                  children: [
                    SettingsTile(
                      icon: Icons.download,
                      title: 'Télécharger mes données',
                      subtitle: 'Recevez une copie de vos données',
                      onTap: () {
                        _showSnackBar(context, 'Demande envoyée (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
