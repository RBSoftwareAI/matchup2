import 'package:flutter/material.dart';

/// Provider for managing app settings
class SettingsProvider with ChangeNotifier {
  // Privacy settings
  bool _isProfileVisible = true;
  String _whoCanSeeMe = 'Tout le monde'; // Options: Tout le monde, Seulement mes matchs, Personne
  bool _showLocation = true;
  bool _sharePreciseLocation = true;
  bool _showOnlineStatus = true;

  // Notification settings
  bool _pushNotificationsEnabled = true;
  bool _newMatchesNotif = true;
  bool _messagesNotif = true;
  bool _matchRequestsNotif = true;
  bool _recommendedProfilesNotif = false;
  bool _promotionsNotif = false;
  bool _emailNotificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  // Account settings
  bool _twoFactorAuthEnabled = false;

  // Getters - Privacy
  bool get isProfileVisible => _isProfileVisible;
  String get whoCanSeeMe => _whoCanSeeMe;
  bool get showLocation => _showLocation;
  bool get sharePreciseLocation => _sharePreciseLocation;
  bool get showOnlineStatus => _showOnlineStatus;

  // Getters - Notifications
  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get newMatchesNotif => _newMatchesNotif;
  bool get messagesNotif => _messagesNotif;
  bool get matchRequestsNotif => _matchRequestsNotif;
  bool get recommendedProfilesNotif => _recommendedProfilesNotif;
  bool get promotionsNotif => _promotionsNotif;
  bool get emailNotificationsEnabled => _emailNotificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;

  // Getters - Account
  bool get twoFactorAuthEnabled => _twoFactorAuthEnabled;

  // Setters - Privacy
  void setProfileVisible(bool value) {
    _isProfileVisible = value;
    notifyListeners();
  }

  void setWhoCanSeeMe(String value) {
    _whoCanSeeMe = value;
    notifyListeners();
  }

  void setShowLocation(bool value) {
    _showLocation = value;
    notifyListeners();
  }

  void setSharePreciseLocation(bool value) {
    _sharePreciseLocation = value;
    notifyListeners();
  }

  void setShowOnlineStatus(bool value) {
    _showOnlineStatus = value;
    notifyListeners();
  }

  // Setters - Notifications
  void setPushNotificationsEnabled(bool value) {
    _pushNotificationsEnabled = value;
    notifyListeners();
  }

  void setNewMatchesNotif(bool value) {
    _newMatchesNotif = value;
    notifyListeners();
  }

  void setMessagesNotif(bool value) {
    _messagesNotif = value;
    notifyListeners();
  }

  void setMatchRequestsNotif(bool value) {
    _matchRequestsNotif = value;
    notifyListeners();
  }

  void setRecommendedProfilesNotif(bool value) {
    _recommendedProfilesNotif = value;
    notifyListeners();
  }

  void setPromotionsNotif(bool value) {
    _promotionsNotif = value;
    notifyListeners();
  }

  void setEmailNotificationsEnabled(bool value) {
    _emailNotificationsEnabled = value;
    notifyListeners();
  }

  void setSoundEnabled(bool value) {
    _soundEnabled = value;
    notifyListeners();
  }

  void setVibrationEnabled(bool value) {
    _vibrationEnabled = value;
    notifyListeners();
  }

  // Setters - Account
  void setTwoFactorAuthEnabled(bool value) {
    _twoFactorAuthEnabled = value;
    notifyListeners();
  }
}
