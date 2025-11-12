import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/auth_footer.dart';

/// Sign Up screen - User registration screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Name validation
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le nom est requis';
    }
    if (value.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
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

  /// Confirm password validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  /// Handle sign up action (mock)
  Future<void> _handleSignUp() async {
    // Validate all fields
    final nameError = _validateName(_nameController.text);
    final emailError = _validateEmail(_emailController.text);
    final passwordError = _validatePassword(_passwordController.text);
    final confirmPasswordError = _validateConfirmPassword(_confirmPasswordController.text);

    if (nameError != null || emailError != null || 
        passwordError != null || confirmPasswordError != null) {
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

    setState(() => _isLoading = false);

    if (mounted) {
      // Navigate to home screen after successful registration
      context.go('/home');
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bienvenue sur MatchUp ! 🎉'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/signin'),
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
                'Créer un compte',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Name field
              CustomTextField(
                label: 'Nom',
                hint: 'Votre nom complet',
                controller: _nameController,
                keyboardType: TextInputType.name,
                validator: _validateName,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              
              const SizedBox(height: 16),
              
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
                hint: 'Choisissez un mot de passe',
                controller: _passwordController,
                obscureText: true,
                validator: _validatePassword,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              
              const SizedBox(height: 16),
              
              // Confirm password field
              CustomTextField(
                label: 'Confirmer le mot de passe',
                hint: 'Confirmez votre mot de passe',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: _validateConfirmPassword,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              
              const SizedBox(height: 32),
              
              // Sign up button
              CustomButton(
                text: 'S\'inscrire',
                onPressed: _handleSignUp,
                isLoading: _isLoading,
              ),
              
              const SizedBox(height: 24),
              
              // Sign in link
              AuthFooter(
                text: 'Vous avez déjà un compte ?',
                linkText: 'J\'ai déjà un compte',
                onLinkPressed: () => context.go('/signin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
