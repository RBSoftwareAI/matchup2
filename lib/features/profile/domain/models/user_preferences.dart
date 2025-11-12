/// User preferences model for matching
class UserPreferences {
  final List<String> preferredGenders;
  final int minAge;
  final int maxAge;
  final int maxDistanceKm;

  const UserPreferences({
    required this.preferredGenders,
    required this.minAge,
    required this.maxAge,
    required this.maxDistanceKm,
  });

  /// Copy method for updates
  UserPreferences copyWith({
    List<String>? preferredGenders,
    int? minAge,
    int? maxAge,
    int? maxDistanceKm,
  }) {
    return UserPreferences(
      preferredGenders: preferredGenders ?? this.preferredGenders,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
    );
  }
}
