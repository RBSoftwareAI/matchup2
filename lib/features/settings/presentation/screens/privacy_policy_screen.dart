import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Privacy Policy screen
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Politique de confidentialité'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Politique de Confidentialité', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text('Dernière mise à jour : Janvier 2024',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 24),
            _buildSection('1. Données collectées',
                'Nous collectons les informations que vous nous fournissez lors de la création de votre compte, incluant votre nom, email, date de naissance, photos et préférences de matching.'),
            _buildSection('2. Utilisation des données',
                'Vos données sont utilisées pour : fournir nos services de matching, personnaliser votre expérience, améliorer notre algorithme et communiquer avec vous.'),
            _buildSection('3. Partage des données',
                'Nous ne vendons jamais vos données personnelles. Vos informations ne sont partagées qu\'avec les autres utilisateurs selon vos paramètres de confidentialité.'),
            _buildSection('4. Sécurité',
                'Nous utilisons des mesures de sécurité standards pour protéger vos données, incluant le chiffrement et des contrôles d\'accès stricts.'),
            _buildSection('5. Vos droits',
                'Vous avez le droit d\'accéder, modifier ou supprimer vos données à tout moment depuis les paramètres de l\'application.'),
            _buildSection('6. Cookies',
                'Nous utilisons des cookies pour améliorer votre expérience. Consultez notre politique des cookies pour plus d\'informations.'),
            _buildSection('7. Contact',
                'Pour toute question concernant cette politique, contactez privacy@matchup.com'),
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
