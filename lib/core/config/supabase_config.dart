/// Supabase Configuration
/// 
/// This file contains the configuration for Supabase backend integration.
/// The URL and anon key are loaded from environment variables for security.
/// 
/// Setup:
/// 1. Get your Supabase URL and anon key from Supabase Dashboard
/// 2. Create a .env file in project root with:
///    SUPABASE_URL=your_supabase_url
///    SUPABASE_ANON_KEY=your_supabase_anon_key
/// 3. Never commit .env file to version control
library;

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // Supabase credentials
  // TODO: Replace with your actual Supabase project credentials
  // Get them from: https://app.supabase.com/project/_/settings/api
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'YOUR_SUPABASE_URL',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'YOUR_SUPABASE_ANON_KEY',
  );

  /// Initialize Supabase
  /// 
  /// Call this method in main() before runApp()
  /// 
  /// Example:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await SupabaseConfig.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: true, // Set to false in production
    );
  }

  /// Get Supabase client instance
  /// 
  /// Use this to access Supabase services throughout your app
  /// 
  /// Example:
  /// ```dart
  /// final users = await SupabaseConfig.client
  ///   .from('users')
  ///   .select()
  ///   .execute();
  /// ```
  static SupabaseClient get client => Supabase.instance.client;

  /// Check if Supabase is initialized
  static bool get isInitialized => true; // Always initialized after calling initialize()

  /// Get current authenticated user
  static User? get currentUser => client.auth.currentUser;

  /// Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;

  /// Get user ID
  static String? get userId => currentUser?.id;

  /// Auth state changes stream
  /// 
  /// Listen to authentication state changes
  /// 
  /// Example:
  /// ```dart
  /// SupabaseConfig.authStateChanges.listen((event) {
  ///   if (event.session != null) {
  ///     // User signed in
  ///   } else {
  ///     // User signed out
  ///   }
  /// });
  /// ```
  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;
}
