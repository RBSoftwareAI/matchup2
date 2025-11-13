import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Cookie Policy screen
class CookiePolicyScreen extends StatelessWidget {
  const CookiePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Politique des cookies'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Politique des Cookies', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text('Dernière mise à jour : Janvier 2024',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 24),
            _buildSection('1. Qu\'est-ce qu\'un cookie ?',
                'Un cookie est un petit fichier texte stocké sur votre appareil lorsque vous utilisez notre application ou site web.'),
            _buildSection('2. Types de cookies utilisés',
                'Cookies essentiels : Nécessaires au fonctionnement du service\nCookies de performance : Analysent l\'utilisation de l\'app\nCookies de préférences : Mémorisent vos choix'),
            _buildSection('3. Pourquoi utilisons-nous des cookies ?',
                'Les cookies nous aident à améliorer votre expérience, personnaliser le contenu, analyser l\'utilisation et assurer la sécurité de votre compte.'),
            _buildSection('4. Gestion des cookies',
                'Vous pouvez gérer vos préférences de cookies depuis les paramètres de votre navigateur ou appareil.'),
            _buildSection('5. Contact',
                'Pour plus d\'informations, contactez cookies@matchup.com'),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(content, style: AppTextStyles.bodyMedium.copyWith(height: 1.6)),
        ],
      ),
    );
  }
}
