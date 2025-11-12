import 'user_preferences.dart';

/// User profile model representing the current user's full profile
class UserProfile {
  final String id;
  final String name;
  final int age;
  final String city;
  final String country;
  final String bio;
  final String? jobTitle;
  final String? company;
  final String? education;
  final int? heightCm;
  final List<String> interests;
  final List<String> photoUrls;
  final UserPreferences preferences;

  const UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.bio,
    this.jobTitle,
    this.company,
    this.education,
    this.heightCm,
    required this.interests,
    required this.photoUrls,
    required this.preferences,
  });

  /// Get main photo URL
  String get mainPhotoUrl => photoUrls.isNotEmpty ? photoUrls.first : '';

  /// Copy method for updates
  UserProfile copyWith({
    String? id,
    String? name,
    int? age,
    String? city,
    String? country,
    String? bio,
    String? jobTitle,
    String? company,
    String? education,
    int? heightCm,
    List<String>? interests,
    List<String>? photoUrls,
    UserPreferences? preferences,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      country: country ?? this.country,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      education: education ?? this.education,
      heightCm: heightCm ?? this.heightCm,
      interests: interests ?? this.interests,
      photoUrls: photoUrls ?? this.photoUrls,
      preferences: preferences ?? this.preferences,
    );
  }
}
