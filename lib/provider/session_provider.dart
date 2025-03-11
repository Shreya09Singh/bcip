import 'dart:async';
import 'dart:convert';
import 'dart:math';

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

  bool _isPlaying = false; // Track playback state
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Future<void> playAudioo(String filePath) async {
    if (filePath.isEmpty) return;

    try {
      await _audioPlayer.play(UrlSource(filePath));
      _isPlaying = true;
      notifyListeners(); // Notify UI
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

//;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Future<void> pauseAudio() async {
    try {
      print("Attempting to pause audio...");
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
        notifyListeners(); // Notify UI
        print("Audio paused successfully.");
      } else {
        print("No active playback found.");
      }
    } catch (e) {
      print("Error pausing audio: $e");
    }
  }
}
