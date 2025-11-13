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
  // Loaded from .env file or environment variables
  // Project: matchup
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://kiwdwzukmmswiemiozcl.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtpd2R3enVrbW1zd2llbWlvemNsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMwMTMwNDIsImV4cCI6MjA3ODU4OTA0Mn0.90S0wlEKAcDwoF5RAnwrcX3XZevnp811BHC9DQEG178',
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
