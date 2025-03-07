import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:bciapplication/model/sessionModel.dart';
import 'package:bciapplication/services/api/API_services.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SessionProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final APIService _sessionService = APIService();
  List<SessionModel> _sessions = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _currentSessionId; // Store currently playing session ID
  String? get currentSessionId => _currentSessionId;

  List<SessionModel> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> searchSessions(String query) async {
    _isLoading = true;
    notifyListeners();

    _sessions = await _sessionService.searchSessions(query);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSessions() async {
    const url = "https://bci-backend-qzzf.onrender.com/session/getSessions";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _sessions =
            data.map((session) => SessionModel.fromJson(session)).toList();
        notifyListeners();
      } else {
        throw Exception("Failed to load sessions");
      }
    } catch (error) {
      print("Error fetching sessions: $error");
    }
  }

  //  void clearSearchResults() {
  //   _searchsonglist = [];
  //   notifyListeners();
  // }

  /// Get file path by session ID
  String? getFilePathById(String sessionId) {
    final session = _sessions.firstWhere(
      (s) => s.sessionId == sessionId,
      orElse: () => SessionModel(
        sessionId: '',
        sessionName: '',
        actualDuration: 0,
        filePath: '',
        imageUrl: '',
      ),
    );
    return session.filePath.isNotEmpty ? session.filePath : null;
  }

  Map<String, bool> _isPlayingMap = {}; // Store playing state for each session

  bool isPlaying(String filePath) => _isPlayingMap[filePath] ?? false;

  Future<void> togglePlay(String filePath) async {
    if (filePath.isEmpty) return;

    bool currentlyPlaying = _isPlayingMap[filePath] ?? false;

    try {
      if (currentlyPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(filePath));
      }

      // Update only this session's state
      _isPlayingMap = {
        filePath: !currentlyPlaying
      }; // Only keep one active at a time
      notifyListeners();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> playAudio(String filePath) async {
    if (filePath.isEmpty) return;

    try {
      await _audioPlayer.play(UrlSource(filePath)); // Play the audio
      _isPlayingMap[filePath] = true; // Mark this file as playing
      notifyListeners();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop(); // Stop the audio completely
      _isPlayingMap.clear(); // Clear all playing states
      notifyListeners();
    } catch (e) {
      print("Error stopping audio: $e");
    }
  }

  Timer? _timer;
  int _remainingTime = 0;

  int get remainingTime => _remainingTime; // Getter for UI

  void startTimer(int minutes) {
    int seconds = minutes * 60;
    if (seconds > 0) {
      _remainingTime = seconds;
      notifyListeners();

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          _remainingTime--;
          notifyListeners(); // Notify UI updates
        } else {
          stopTimer(); // ✅ Stop when time reaches 0
        }
      });
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      notifyListeners();
      print("Timer stopped at $_remainingTime seconds");
    }
  }
}
