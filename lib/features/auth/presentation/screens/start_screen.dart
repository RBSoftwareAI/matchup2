import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_footer.dart';

/// Start screen - First screen users see when opening the app
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // App logo placeholder
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.favorite,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Title
              Text(
                'Trouvez votre match parfait avec l\'IA',
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                'Notre algorithme analyse vos préférences et vous connecte aux profils compatibles.',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              
              const Spacer(),
              
              // Start button
              CustomButton(
                text: 'Démarrer',
                onPressed: () {
                  context.go('/signin');
                },
              ),
              
              const SizedBox(height: 24),
              
              // Legal footer
              const LegalFooter(),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
