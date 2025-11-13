import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/settings_section.dart';
import '../widgets/custom_switch_tile.dart';
import '../providers/settings_provider.dart';

/// Notifications settings screen
class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Notifications'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Push Notifications Section
                SettingsSection(
                  title: 'Notifications push',
                  children: [
                    CustomSwitchTile(
                      title: 'Activer les notifications',
                      subtitle: 'Recevoir des notifications push',
                      value: settings.pushNotificationsEnabled,
                      onChanged: (value) {
                        settings.setPushNotificationsEnabled(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Types of Notifications Section
                SettingsSection(
                  title: 'Types de notifications',
                  children: [
                    CustomSwitchTile(
                      title: 'Nouveaux matchs',
                      subtitle: 'Quand vous avez un nouveau match',
                      value: settings.newMatchesNotif,
                      enabled: settings.pushNotificationsEnabled,
                      onChanged: (value) {
                        settings.setNewMatchesNotif(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                    ),
                    CustomSwitchTile(
                      title: 'Messages',
                      subtitle: 'Quand vous recevez un nouveau message',
                      value: settings.messagesNotif,
                      enabled: settings.pushNotificationsEnabled,
                      onChanged: (value) {
                        settings.setMessagesNotif(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                    ),
                    CustomSwitchTile(
                      title: 'Demandes de match',
                      subtitle: 'Quand quelqu\'un vous envoie une demande',
                      value: settings.matchRequestsNotif,
                      enabled: settings.pushNotificationsEnabled,
                      onChanged: (value) {
                        settings.setMatchRequestsNotif(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                    ),
                    CustomSwitchTile(
                      title: 'Profils recommandés',
                      subtitle: 'Suggestions de profils qui pourraient vous plaire',
                      value: settings.recommendedProfilesNotif,
                      enabled: settings.pushNotificationsEnabled,
                      onChanged: (value) {
                        settings.setRecommendedProfilesNotif(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                    ),
                    CustomSwitchTile(
                      title: 'Promotions et offres',
                      subtitle: 'Offres spéciales et nouveautés',
                      value: settings.promotionsNotif,
                      enabled: settings.pushNotificationsEnabled,
                      onChanged: (value) {
                        settings.setPromotionsNotif(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Email Notifications Section
                SettingsSection(
                  title: 'Notifications par email',
                  children: [
                    CustomSwitchTile(
                      title: 'Recevoir des emails',
                      subtitle: 'Résumés hebdomadaires et actualités importantes',
                      value: settings.emailNotificationsEnabled,
                      onChanged: (value) {
                        settings.setEmailNotificationsEnabled(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Sound and Vibration Section
                SettingsSection(
                  title: 'Sons et vibrations',
                  children: [
                    CustomSwitchTile(
                      title: 'Sons de notification',
                      value: settings.soundEnabled,
                      onChanged: (value) {
                        settings.setSoundEnabled(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
                      },
                    ),
                    CustomSwitchTile(
                      title: 'Vibrations',
                      value: settings.vibrationEnabled,
                      onChanged: (value) {
                        settings.setVibrationEnabled(value);
                        _showSnackBar(context, 'Préférences de notifications mises à jour (mock)');
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
