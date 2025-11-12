import 'package:flutter/material.dart';
import '../../data/mock_user.dart';
import '../../domain/models/user_profile.dart';

/// Provider for managing user profile
class ProfileProvider with ChangeNotifier {
  UserProfile _profile = mockUserProfile;

  /// Get current user profile
  UserProfile get profile => _profile;

  /// Update user profile
  void updateProfile(UserProfile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  /// Update specific fields
  void updateName(String name) {
    _profile = _profile.copyWith(name: name);
    notifyListeners();
  }

  void updateBio(String bio) {
    _profile = _profile.copyWith(bio: bio);
    notifyListeners();
  }

  void updateJobTitle(String jobTitle) {
    _profile = _profile.copyWith(jobTitle: jobTitle);
    notifyListeners();
  }

  void updateCompany(String company) {
    _profile = _profile.copyWith(company: company);
    notifyListeners();
  }

  void updateEducation(String education) {
    _profile = _profile.copyWith(education: education);
    notifyListeners();
  }

  void updateCity(String city) {
    _profile = _profile.copyWith(city: city);
    notifyListeners();
  }

  void updateCountry(String country) {
    _profile = _profile.copyWith(country: country);
    notifyListeners();
  }

  void updateHeight(int heightCm) {
    _profile = _profile.copyWith(heightCm: heightCm);
    notifyListeners();
  }

  void updateInterests(List<String> interests) {
    _profile = _profile.copyWith(interests: interests);
    notifyListeners();
  }

  void addInterest(String interest) {
    final updatedInterests = [..._profile.interests, interest];
    _profile = _profile.copyWith(interests: updatedInterests);
    notifyListeners();
  }

  void removeInterest(String interest) {
    final updatedInterests = _profile.interests
        .where((i) => i != interest)
        .toList();
    _profile = _profile.copyWith(interests: updatedInterests);
    notifyListeners();
  }
}
