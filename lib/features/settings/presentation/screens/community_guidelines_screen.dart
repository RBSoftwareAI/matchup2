import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Community Guidelines screen
class CommunityGuidelinesScreen extends StatelessWidget {
  const CommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Règles de la communauté'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Règles de la Communauté', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text('Dernière mise à jour : Janvier 2024',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 24),
            _buildSection('1. Soyez respectueux',
                'Traitez les autres avec respect et courtoisie. Le harcèlement, les insultes et les comportements intimidants ne sont pas tolérés.'),
            _buildSection('2. Soyez authentique',
                'Utilisez de vraies photos de vous et des informations véridiques. Les faux profils seront supprimés.'),
            _buildSection('3. Restez approprié',
                'Le contenu sexuellement explicite, violent ou offensant est interdit. Gardez vos conversations appropriées.'),
            _buildSection('4. Protégez votre vie privée',
                'Ne partagez pas d\'informations personnelles sensibles (adresse, numéros de compte) avec des inconnus.'),
            _buildSection('5. Signalez les comportements inappropriés',
                'Si vous rencontrez un comportement qui viole ces règles, signalez-le immédiatement.'),
            _buildSection('6. Pas de spam ni de promotion',
                'N\'utilisez pas MatchUp pour faire de la publicité ou envoyer des messages en masse.'),
            _buildSection('7. Conséquences',
                'La violation de ces règles peut entraîner la suspension ou la suppression définitive de votre compte.'),
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
