// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:bciapplication/widget/TabBar.dart';
import 'package:bciapplication/Screens/progress/TabBar_screen.dart';
import 'package:bciapplication/Screens/progress/day_view_screen.dart';
import 'package:bciapplication/Screens/session/statCard.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatefulWidget {
  final TextEditingController controller;
  const SessionScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  int remainingTime = 0; // 5 minutes in seconds
  Timer? timer;
  final Random _random = Random();
  int _randomNumber = 0;

  void meditationTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      generateRandomNumber();
    });
  }

  void generateRandomNumber() {
    setState(() {
      _randomNumber =
          _random.nextInt(100); // Generates a random number between 0 and 99
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    meditationTimer();
  }

  void startTimer() {
    int min = int.tryParse(widget.controller.text) ?? 0;
    int seconds = min * 60;
    if (seconds > 0) {
      setState(() {
        remainingTime = seconds;
      });

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (remainingTime > 0) {
          setState(() {
            remainingTime--;
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  void timerstop() {
    timerstop();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        remainingTime / (int.tryParse(widget.controller.text)! * 60);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular Progress Indicator
                  SizedBox(
                    width: 230,
                    height: 230,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade800,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(brandPrimaryColor),
                    ),
                  ),
                  // Circular Background Glow

                  // Timer Text
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Timer",
                        style: TextStyle(
                            color: textPrimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Now Playing
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Now Playing : White noise",
                style: TextStyle(
                    color: textPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),

            // Waveform (Placeholder)
            SizedBox(
                height: 50,
                width: 400,
                child: Image.asset('assets/waves.png', fit: BoxFit.cover)),
            SizedBox(height: 30),

            // Statistics Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatCard(
                    imagePath: 'assets/lowestTime.png',
                    title: 'Lowest Time',
                    time: '3 min',
                    timeColor: Colors.red),
                StatCard(
                    imagePath: 'assets/averageTime.png',
                    title: 'Average Time',
                    time: '5 min',
                    timeColor: Colors.yellow),
                StatCard(
                    imagePath: 'assets/highestTime.png',
                    title: 'Highest Time',
                    time: '10 min',
                    timeColor: Colors.green)
              ],
            ),
            SizedBox(height: 30),

            // Meditation Count
            Text(
              "Meditation time",
              style: TextStyle(
                  color: textPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "$_randomNumber",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Stop and Next Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OnboardingButton(onPressed: () {}, buttonText: 'Stop'),
                OnboardingButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabbarScreen()));
                    },
                    buttonText: 'Next')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
