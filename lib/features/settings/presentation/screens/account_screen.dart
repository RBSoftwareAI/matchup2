import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/custom_switch_tile.dart';
import '../providers/settings_provider.dart';

/// Account and security settings screen
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Compte & sécurité'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Account Information Section
                SettingsSection(
                  title: 'Informations du compte',
                  children: [
                    SettingsTile(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      subtitle: 'user@example.com',
                      onTap: () {
                        _showSnackBar(context, 'Modification email (placeholder)');
                      },
                    ),
                    SettingsTile(
                      icon: Icons.phone_outlined,
                      title: 'Numéro de téléphone',
                      subtitle: '+33 6 12 34 56 78',
                      onTap: () {
                        _showSnackBar(context, 'Modification téléphone (placeholder)');
                      },
                      showDivider: false,
                    ),
                  ],
                ),

                // Security Section
                SettingsSection(
                  title: 'Sécurité',
                  children: [
                    SettingsTile(
                      icon: Icons.lock_outline,
                      title: 'Changer le mot de passe',
                      onTap: () => _showChangePasswordDialog(context),
                    ),
                    CustomSwitchTile(
                      title: 'Authentification à deux facteurs',
                      subtitle: 'Sécurité renforcée pour votre compte',
                      value: settings.twoFactorAuthEnabled,
                      onChanged: (value) {
                        settings.setTwoFactorAuthEnabled(value);
                        _showSnackBar(
                          context,
                          value
                              ? 'Authentification à deux facteurs activée (mock)'
                              : 'Authentification à deux facteurs désactivée (mock)',
                        );
                      },
                    ),
                    SettingsTile(
                      icon: Icons.devices,
                      title: 'Appareils connectés',
                      subtitle: '2 appareils actifs',
                      onTap: () => _showConnectedDevicesDialog(context),
                      showDivider: false,
                    ),
                  ],
                ),

                // Subscription Section
                SettingsSection(
                  title: 'Abonnement',
                  children: [
                    SettingsTile(
                      icon: Icons.card_membership,
                      title: 'Plan actuel',
                      subtitle: 'Gratuit',
                      onTap: () {
                        _showSnackBar(context, 'Fonctionnalité à venir');
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          _showSnackBar(context, 'Fonctionnalité à venir');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: const Text('Passer à Premium'),
                      ),
                    ),
                  ],
                ),

                // Account Management Section
                SettingsSection(
                  title: 'Gestion du compte',
                  children: [
                    SettingsTile(
                      icon: Icons.pause_circle_outline,
                      title: 'Suspendre mon compte temporairement',
                      onTap: () => _showSuspendAccountDialog(context),
                    ),
                    SettingsTile(
                      icon: Icons.delete_forever,
                      title: 'Supprimer mon compte',
                      onTap: () => _showDeleteAccountDialog(context),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: AppColors.error,
                      ),
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

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le mot de passe'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Ancien mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmer le mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSnackBar(context, 'Mot de passe modifié (mock)');
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _showConnectedDevicesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Appareils connectés'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.smartphone),
              title: const Text('iPhone 13'),
              subtitle: const Text('Actif maintenant'),
              trailing: const Text(
                'Cet appareil',
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.laptop_mac),
              title: const Text('MacBook Pro'),
              subtitle: const Text('Il y a 2 jours'),
              trailing: TextButton(
                onPressed: () {
                  _showSnackBar(context, 'Appareil déconnecté (mock)');
                },
                child: const Text('Déconnecter'),
              ),
            ),
          ],
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

  void _showSuspendAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Suspendre le compte'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: const Text(
          'Votre profil sera masqué et vous ne recevrez plus de notifications. Vous pourrez réactiver votre compte à tout moment.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSnackBar(context, 'Compte suspendu (mock)');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.warning),
            child: const Text('Suspendre'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le compte'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: const Text(
          'Cette action est irréversible. Toutes vos données seront définitivement supprimées.',
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSnackBar(context, 'Compte supprimé (mock)');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Supprimer'),
          ),
        ],
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
