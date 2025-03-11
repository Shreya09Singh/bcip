import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int totalTime = 1;
  int _remainingTime = 0;
  Timer? _timer;

  // List<int> get randomNumbers =>
  //     _randomNumbers; // Getter to access the stored numbers
  final Random _random = Random();

  int _currentRandomNumber = 0;
  final List<int> _randomNumbers = []; // List to store all generated numbers

  int get currentRandomNumber => _currentRandomNumber;
  List<int> get randomNumbers => _randomNumbers; // Read-only list

  int get remainingTime => _remainingTime;
  double get progressindicator => _remainingTime / totalTime;
  void startTimer(int minutes) {
    // if (_timer != null) {
    //   _timer!.cancel();
    //   _timer = null;
    // }

    totalTime = minutes * 60; // Store total time
    _remainingTime = totalTime;
    notifyListeners();
    //// Notify UI initially

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners(); // Update UI every second
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null; // ✅ Prevent memory leaks

      print(
          "Before notifyListeners: Remaining Time = $_remainingTime"); // Debugging
      notifyListeners();
      print("After notifyListeners: UI should rebuild now!"); // Debugging
    }
  }

  @override
  void dispose() {
    stopTimer(); // ✅ Ensure timer is stopped when widget is disposed
    super.dispose();
  }

  // int getRemainingTime() {
  //   return _remainingTime;
  // }

  void meditationTimer() {
    _randomNumbers.clear(); // ✅ First, clear the list
    notifyListeners(); // ✅ Notify UI that list is cleared

    _timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      _currentRandomNumber = _random.nextInt(100) + 1; // ✅ Generate number
      _randomNumbers.add(_currentRandomNumber); // ✅ Store in list
      notifyListeners(); // ✅ Update UI
    });
  }

  void stopMeditationTimer() {
    _timer?.cancel();

    print("Final Numbers: $_randomNumbers"); // Send to API here
  }
}
