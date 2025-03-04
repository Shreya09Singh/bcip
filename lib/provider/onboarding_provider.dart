import 'package:bciapplication/Screens/meditaion/meditaion_screen.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/utils/string.dart';
import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  String get currentImage => AppAssets.images[_currentIndex];
  String get currentContent => AppString.cardContents[_currentIndex];

  void nextStep(BuildContext context) {
    if (_currentIndex < AppAssets.images.length - 1) {
      _currentIndex++;
      notifyListeners();
    } else {
      // Navigate to HomeScreen when last step is reached
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MeditaionScreen()),
      );
    }
  }

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
