import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Terms of Service screen
class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text('Conditions d\'utilisation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Conditions Générales d\'Utilisation',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: 8),
            Text(
              'Dernière mise à jour : Janvier 2024',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Acceptation des conditions',
              'En utilisant l\'application MatchUp, vous acceptez d\'être lié par ces conditions générales d\'utilisation. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser nos services.',
            ),
            _buildSection(
              '2. Éligibilité',
              'Vous devez avoir au moins 18 ans pour utiliser MatchUp. En créant un compte, vous confirmez que vous avez l\'âge légal requis et que toutes les informations fournies sont exactes.',
            ),
            _buildSection(
              '3. Création de compte',
              'Vous êtes responsable de maintenir la confidentialité de votre compte et de votre mot de passe. Vous acceptez de nous informer immédiatement de toute utilisation non autorisée de votre compte.',
            ),
            _buildSection(
              '4. Utilisation du service',
              'Vous vous engagez à utiliser MatchUp de manière responsable et conforme aux lois applicables. Vous ne devez pas :\n• Harceler, menacer ou intimider d\'autres utilisateurs\n• Publier du contenu offensant, illégal ou trompeur\n• Usurper l\'identité d\'une autre personne\n• Utiliser le service à des fins commerciales sans autorisation',
            ),
            _buildSection(
              '5. Contenu utilisateur',
              'Vous conservez la propriété de tout contenu que vous publiez sur MatchUp. Cependant, vous nous accordez une licence mondiale, non exclusive et gratuite pour utiliser, modifier et afficher ce contenu dans le cadre de nos services.',
            ),
            _buildSection(
              '6. Modération et suspension',
              'Nous nous réservons le droit de modérer le contenu et de suspendre ou résilier tout compte qui viole nos conditions d\'utilisation ou nos règles de la communauté.',
            ),
            _buildSection(
              '7. Limitation de responsabilité',
              'MatchUp est fourni "tel quel". Nous ne garantissons pas que le service sera ininterrompu ou exempt d\'erreurs. Nous ne sommes pas responsables des interactions entre utilisateurs en dehors de notre plateforme.',
            ),
            _buildSection(
              '8. Modifications des conditions',
              'Nous pouvons modifier ces conditions à tout moment. Les modifications prennent effet dès leur publication sur l\'application. Votre utilisation continue du service constitue une acceptation des nouvelles conditions.',
            ),
            _buildSection(
              '9. Résiliation',
              'Vous pouvez supprimer votre compte à tout moment depuis les paramètres. Nous pouvons également résilier votre compte si vous violez ces conditions.',
            ),
            _buildSection(
              '10. Contact',
              'Pour toute question concernant ces conditions, contactez-nous à legal@matchup.com',
            ),
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
          Text(
            title,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
