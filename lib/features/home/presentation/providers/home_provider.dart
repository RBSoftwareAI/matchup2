import 'package:flutter/foundation.dart';
import '../../data/mock_profiles.dart';
import '../../domain/models/profile.dart';

/// Filter types for profile list
enum ProfileFilter {
  all,
  recommended,
  newProfiles,
}

/// Provider for managing home screen state
class HomeProvider extends ChangeNotifier {
  // Current filter
  ProfileFilter _currentFilter = ProfileFilter.all;
  ProfileFilter get currentFilter => _currentFilter;

  // All profiles
  final List<Profile> _allProfiles = List.from(mockProfiles);

  // Current user for compatibility calculations
  final Profile _currentUser = mockCurrentUser;
  Profile get currentUser => _currentUser;

  // Filtered profiles based on current filter
  List<Profile> get filteredProfiles {
    switch (_currentFilter) {
      case ProfileFilter.all:
        return _allProfiles;
      case ProfileFilter.recommended:
        return _getRecommendedProfiles();
      case ProfileFilter.newProfiles:
        return _getNewProfiles();
    }
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Change filter
  void setFilter(ProfileFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  /// Get recommended profiles based on compatibility
  List<Profile> _getRecommendedProfiles() {
    final recommended = List<Profile>.from(_allProfiles);
    recommended.sort((a, b) {
      final scoreA = a.getCompatibilityScore(_currentUser);
      final scoreB = b.getCompatibilityScore(_currentUser);
      return scoreB.compareTo(scoreA);
    });
    // Return top 15 most compatible
    return recommended.take(15).toList();
  }

  /// Get newest profiles (last 20)
  List<Profile> _getNewProfiles() {
    final newProfiles = List<Profile>.from(_allProfiles);
    newProfiles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return newProfiles.take(20).toList();
  }

  /// Handle swipe action (like)
  void onSwipeRight(Profile profile) {
    if (kDebugMode) {
      debugPrint('❤️ Liked profile: ${profile.name}');
    }
    _removeProfile(profile);
  }

  /// Handle swipe action (dislike)
  void onSwipeLeft(Profile profile) {
    if (kDebugMode) {
      debugPrint('❌ Disliked profile: ${profile.name}');
    }
    _removeProfile(profile);
  }

  /// Handle swipe up action (super like/match)
  void onSwipeUp(Profile profile) {
    if (kDebugMode) {
      debugPrint('🔥 Super liked profile: ${profile.name}');
    }
    _removeProfile(profile);
  }

  /// Remove profile from list after swipe
  void _removeProfile(Profile profile) {
    _allProfiles.removeWhere((p) => p.id == profile.id);
    notifyListeners();
  }

  /// Reset profiles (for testing)
  void resetProfiles() {
    _allProfiles.clear();
    _allProfiles.addAll(mockProfiles);
    notifyListeners();
  }

  /// Get remaining profiles count
  int get remainingProfilesCount => filteredProfiles.length;
}
