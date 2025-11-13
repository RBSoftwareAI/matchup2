import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/faq_expansion_tile.dart';

/// Help and support screen
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static final List<Map<String, String>> faqs = [
    {
      'q': 'Comment fonctionne l\'algorithme de matching ?',
      'a': 'Notre algorithme analyse vos préférences, centres d\'intérêt et comportements pour vous proposer des profils compatibles. Plus vous utilisez l\'application, plus les suggestions s\'affinent.'
    },
    {
      'q': 'Comment modifier mes préférences de recherche ?',
      'a': 'Allez dans Profil > Éditer le profil > Préférences. Vous pouvez ajuster l\'âge, la distance et les genres recherchés.'
    },
    {
      'q': 'Pourquoi je ne vois plus de profils ?',
      'a': 'Cela peut arriver si vous avez vu tous les profils disponibles dans votre zone. Essayez d\'élargir votre distance de recherche ou revenez plus tard.'
    },
    {
      'q': 'Comment signaler un profil ?',
      'a': 'Sur le profil suspect, appuyez sur l\'icône \'…\' puis \'Signaler\'. Notre équipe examinera votre signalement dans les 24h.'
    },
    {
      'q': 'Comment annuler un match ?',
      'a': 'Allez dans vos Matchs confirmés, sélectionnez le profil, puis \'Annuler le match\' dans les options.'
    },
    {
      'q': 'Mes messages ne s\'envoient pas',
      'a': 'Vérifiez votre connexion internet. Si le problème persiste, essayez de fermer et rouvrir l\'application.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Aide'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // FAQ Section
            SettingsSection(
              title: 'Questions fréquentes',
              padding: const EdgeInsets.all(20),
              children: faqs
                  .map((faq) => FAQExpansionTile(
                        question: faq['q']!,
                        answer: faq['a']!,
                      ))
                  .toList(),
            ),

            // Support Center Section
            SettingsSection(
              title: 'Centre d\'assistance',
              children: [
                SettingsTile(
                  icon: Icons.email_outlined,
                  title: 'Contacter le support',
                  subtitle: 'support@matchup.com',
                  onTap: () {
                    _showSnackBar(context, 'support@matchup.com');
                  },
                ),
                SettingsTile(
                  icon: Icons.bug_report_outlined,
                  title: 'Signaler un bug',
                  subtitle: 'Aidez-nous à améliorer l\'application',
                  onTap: () => _showBugReportDialog(context),
                  showDivider: false,
                ),
              ],
            ),

            // Resources Section
            SettingsSection(
              title: 'Ressources',
              children: [
                SettingsTile(
                  icon: Icons.menu_book,
                  title: 'Guide d\'utilisation',
                  onTap: () {
                    _showSnackBar(context, 'Page placeholder');
                  },
                ),
                SettingsTile(
                  icon: Icons.security,
                  title: 'Conseils de sécurité',
                  onTap: () {
                    _showSnackBar(context, 'Page placeholder');
                  },
                  showDivider: false,
                ),
              ],
            ),

            // App Information Section
            SettingsSection(
              title: 'Informations',
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Version de l\'application',
                    style: AppTextStyles.bodyMedium,
                  ),
                  trailing: Text(
                    '1.0.0',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _showSnackBar(context, 'Vous utilisez la dernière version');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Vérifier les mises à jour'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBugReportDialog(BuildContext context) {
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Signaler un bug'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description du problème',
                hintText: 'Décrivez le bug rencontré...',
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
              _showSnackBar(context, 'Bug signalé (mock). Merci !');
            },
            child: const Text('Envoyer'),
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
