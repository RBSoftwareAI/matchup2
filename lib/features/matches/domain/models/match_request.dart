/// Match request model representing a pending match
class MatchRequest {
  final String id;
  final String name;
  final int age;
  final String jobTitle;
  final double distanceKm;
  final String photoUrl;
  final List<String> interests;
  final DateTime createdAt;

  const MatchRequest({
    required this.id,
    required this.name,
    required this.age,
    required this.jobTitle,
    required this.distanceKm,
    required this.photoUrl,
    required this.interests,
    required this.createdAt,
  });

  /// Copy method for updates
  MatchRequest copyWith({
    String? id,
    String? name,
    int? age,
    String? jobTitle,
    double? distanceKm,
    String? photoUrl,
    List<String>? interests,
    DateTime? createdAt,
  }) {
    return MatchRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      jobTitle: jobTitle ?? this.jobTitle,
      distanceKm: distanceKm ?? this.distanceKm,
      photoUrl: photoUrl ?? this.photoUrl,
      interests: interests ?? this.interests,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
