import 'package:flutter/material.dart';
import '../../data/mock_matches.dart';
import '../../domain/models/match_request.dart';
import '../../../chat/domain/models/message.dart';

/// Provider for managing match requests and confirmed matches
class MatchesProvider with ChangeNotifier {
  // List of pending match requests
  List<MatchRequest> _requests = [...mockMatchRequests];
  
  // List of confirmed matches (as conversations)
  final List<Map<String, dynamic>> _confirmedMatches = [];

  /// Get pending requests
  List<MatchRequest> get requests => _requests;

  /// Get confirmed matches
  List<Map<String, dynamic>> get confirmedMatches => _confirmedMatches;

  /// Accept a match request
  /// Moves the request to confirmed matches and creates a conversation
  void acceptRequest(MatchRequest request) {
    // Remove from requests
    _requests = _requests.where((r) => r.id != request.id).toList();
    
    // Add to confirmed matches (as a conversation)
    _confirmedMatches.add({
      'userId': request.id,
      'userName': request.name,
      'userPhotoUrl': request.photoUrl,
      'lastMessage': Message(
        id: 'msg_match_${request.id}',
        senderId: request.id,
        senderName: request.name,
        receiverId: 'user_current',
        content: '👋 Salut ! Content qu\'on ait matché !',
        timestamp: DateTime.now(),
        isRead: false,
      ),
    });
    
    notifyListeners();
  }

  /// Decline a match request
  /// Removes the request from the list
  void declineRequest(MatchRequest request) {
    _requests = _requests.where((r) => r.id != request.id).toList();
    notifyListeners();
  }

  /// Get a confirmed match by user ID
  Map<String, dynamic>? getConfirmedMatch(String userId) {
    try {
      return _confirmedMatches.firstWhere(
        (match) => match['userId'] == userId,
      );
    } catch (e) {
      return null;
    }
  }
}
