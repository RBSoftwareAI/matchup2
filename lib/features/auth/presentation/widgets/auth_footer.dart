import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';

/// Footer widget for authentication screens with legal links
class AuthFooter extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback? onLinkPressed;
  
  const AuthFooter({
    super.key,
    required this.text,
    required this.linkText,
    this.onLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.caption,
        children: [
          TextSpan(text: text),
          const TextSpan(text: ' '),
          TextSpan(
            text: linkText,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onLinkPressed,
          ),
        ],
      ),
    );
  }
}

/// Legal footer widget for terms and privacy policy
class LegalFooter extends StatelessWidget {
  const LegalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.caption,
        children: [
          const TextSpan(text: 'En continuant, vous acceptez nos '),
          TextSpan(
            text: 'Conditions',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to Terms of Service (mock)
              },
          ),
          const TextSpan(text: ' et notre '),
          TextSpan(
            text: 'Politique de confidentialité',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigate to Privacy Policy (mock)
              },
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}
