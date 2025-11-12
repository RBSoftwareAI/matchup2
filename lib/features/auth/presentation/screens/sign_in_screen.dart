import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_footer.dart';

/// Sign In screen - User authentication screen
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Email validation regex
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'L\'email est requis';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  /// Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  /// Handle sign in action (mock)
  Future<void> _handleSignIn() async {
    // Validate fields
    final emailError = _validateEmail(_emailController.text);
    final passwordError = _validatePassword(_passwordController.text);

    if (emailError != null || passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les erreurs'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      
      // Navigate to home screen immediately
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/start'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // Title
              Text(
                'Connexion',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Email field
              CustomTextField(
                label: 'Email',
                hint: 'votre@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              
              const SizedBox(height: 16),
              
              // Password field
              CustomTextField(
                label: 'Mot de passe',
                hint: 'Entrez votre mot de passe',
                controller: _passwordController,
                obscureText: true,
                validator: _validatePassword,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              
              const SizedBox(height: 12),
              
              // Forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password functionality (inactive for now)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fonctionnalité en cours de développement'),
                      ),
                    );
                  },
                  child: Text(
                    'Mot de passe oublié ?',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Sign in button
              CustomButton(
                text: 'Se connecter',
                onPressed: _handleSignIn,
                isLoading: _isLoading,
              ),
              
              const SizedBox(height: 24),
              
              // Create account link
              AuthFooter(
                text: 'Vous n\'avez pas de compte ?',
                linkText: 'Créer un compte',
                onLinkPressed: () => context.go('/signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
