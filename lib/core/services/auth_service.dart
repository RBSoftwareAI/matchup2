/// Authentication Service
/// 
/// Handles all authentication operations with Supabase Auth
/// - Sign up with email/password
/// - Sign in with email/password
/// - Sign out
/// - Password reset
/// - Email verification
library;

import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class AuthService {
  final SupabaseClient _supabase = SupabaseConfig.client;

  /// Sign up new user with email and password
  /// 
  /// Returns AuthResponse with user data and session
  /// Throws AuthException on failure
  /// 
  /// Example:
  /// ```dart
  /// try {
  ///   final response = await authService.signUp(
  ///     email: 'user@example.com',
  ///     password: 'securepass123',
  ///   );
  ///   print('User created: ${response.user?.id}');
  /// } catch (e) {
  ///   print('Error: $e');
  /// }
  /// ```
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );
      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  /// Sign in existing user with email and password
  /// 
  /// Returns AuthResponse with user data and session
  /// Throws AuthException on failure
  /// 
  /// Example:
  /// ```dart
  /// try {
  ///   final response = await authService.signIn(
  ///     email: 'user@example.com',
  ///     password: 'securepass123',
  ///   );
  ///   print('User signed in: ${response.user?.id}');
  /// } catch (e) {
  ///   print('Error: $e');
  /// }
  /// ```
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  /// Sign out current user
  /// 
  /// Clears the session and signs out the user
  /// 
  /// Example:
  /// ```dart
  /// await authService.signOut();
  /// ```
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  /// Send password reset email
  /// 
  /// Sends a password reset link to the user's email
  /// 
  /// Example:
  /// ```dart
  /// await authService.resetPassword('user@example.com');
  /// ```
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  /// Update user password
  /// 
  /// Updates the password for the current authenticated user
  /// 
  /// Example:
  /// ```dart
  /// await authService.updatePassword('newSecurePass123');
  /// ```
  Future<UserResponse> updatePassword(String newPassword) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Password update failed: $e');
    }
  }

  /// Update user email
  /// 
  /// Updates the email for the current authenticated user
  /// Sends verification email to new address
  /// 
  /// Example:
  /// ```dart
  /// await authService.updateEmail('newemail@example.com');
  /// ```
  Future<UserResponse> updateEmail(String newEmail) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(email: newEmail),
      );
      return response;
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw Exception('Email update failed: $e');
    }
  }

  /// Get current authenticated user
  /// 
  /// Returns User object if authenticated, null otherwise
  /// 
  /// Example:
  /// ```dart
  /// final user = authService.currentUser;
  /// if (user != null) {
  ///   print('User ID: ${user.id}');
  ///   print('Email: ${user.email}');
  /// }
  /// ```
  User? get currentUser => _supabase.auth.currentUser;

  /// Check if user is authenticated
  /// 
  /// Returns true if user is signed in, false otherwise
  /// 
  /// Example:
  /// ```dart
  /// if (authService.isAuthenticated) {
  ///   // User is signed in
  /// } else {
  ///   // User is not signed in
  /// }
  /// ```
  bool get isAuthenticated => currentUser != null;

  /// Get current user ID
  /// 
  /// Returns user ID if authenticated, null otherwise
  String? get userId => currentUser?.id;

  /// Get current user email
  /// 
  /// Returns user email if authenticated, null otherwise
  String? get userEmail => currentUser?.email;

  /// Listen to auth state changes
  /// 
  /// Stream of authentication state changes
  /// 
  /// Example:
  /// ```dart
  /// authService.authStateChanges.listen((event) {
  ///   if (event.session != null) {
  ///     // User signed in
  ///     print('User: ${event.session?.user.id}');
  ///   } else {
  ///     // User signed out
  ///   }
  /// });
  /// ```
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}
