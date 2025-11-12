/// Profile model representing a user profile
class Profile {
  final String id;
  final String name;
  final int age;
  final String jobTitle;
  final double distanceKm;
  final List<String> interests;
  final String photoUrl;
  final DateTime createdAt;
  final String gender; // 'male', 'female', 'other'
  final String bio;

  const Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.jobTitle,
    required this.distanceKm,
    required this.interests,
    required this.photoUrl,
    required this.createdAt,
    required this.gender,
    required this.bio,
  });

  /// Calculate compatibility score with another profile
  /// Returns a score between 0.0 and 1.0
  double getCompatibilityScore(Profile currentUser) {
    // Simple mock algorithm based on common interests
    final commonInterests = interests
        .where((interest) => currentUser.interests.contains(interest))
        .length;
    
    if (currentUser.interests.isEmpty) return 0.5;
    
    final score = commonInterests / currentUser.interests.length;
    return score.clamp(0.0, 1.0);
  }

  /// Copy method for potential updates
  Profile copyWith({
    String? id,
    String? name,
    int? age,
    String? jobTitle,
    double? distanceKm,
    List<String>? interests,
    String? photoUrl,
    DateTime? createdAt,
    String? gender,
    String? bio,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      jobTitle: jobTitle ?? this.jobTitle,
      distanceKm: distanceKm ?? this.distanceKm,
      interests: interests ?? this.interests,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
    );
  }
}
