// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:bciapplication/Screens/registration/sharedpreference.dart';
import 'package:bciapplication/provider/getsession_provider.dart';
import 'package:bciapplication/services/getsession_api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bciapplication/Screens/progress/TabBar_screen.dart';
import 'package:bciapplication/Screens/session/statCard.dart';
import 'package:bciapplication/provider/session_provider.dart';
import 'package:bciapplication/services/api/API_services.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/widget/onboarding_button.dart';

class SessionScreen extends StatefulWidget {
  final TextEditingController controller;
  final String sessionName;
  final String sessionId;
  final double thresholdvalue;

  const SessionScreen({
    Key? key,
    required this.controller,
    required this.sessionName,
    required this.sessionId,
    required this.thresholdvalue,
  }) : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final APIService _apiService = APIService();
  final GetsessionApiServices getsessionApiServices = GetsessionApiServices();
  int remainingTime = 0;
  Timer? timer;
  final Random _random = Random();
  int _randomNumber = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
    meditationTimer();
  }

  int getRemainingTime() {
    return remainingTime;
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
          stopTimer(); // ✅ Stop timer when it reaches 0
        }
      });
    }
  }

  void meditationTimer() {
    Timer.periodic(Duration(seconds: 2), (Timer t) {
      // generateRandomNumber();
    });
  }

  // void generateRandomNumber() {
  //   setState(() {
  //     _randomNumber = _random.nextInt(100); // Generates a number between 0-99
  //   });
  // }

  List<int> generateRandomFocusValues(int count) {
    Random random = Random();
    return List.generate(count, (_) => random.nextInt(100) + 1);
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel(); // ✅ Stop the timer
      timer = null; // ✅ Avoid memory leaks
      print("Timer stopped at $remainingTime seconds");
    }
  }

  @override
  void dispose() {
    stopTimer(); // ✅ Ensure timer is stopped when widget is disposed
    super.dispose();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
  }

  Future<void> addsessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) return;

    String sessionname = widget.sessionName;
    String sessionid = widget.sessionId;
    int actualduration = remainingTime;
    String selectedduration = widget.controller.text;
    List<int> focusvalue = generateRandomFocusValues(10);
    double selectedthresholdvalue = widget.thresholdvalue;

    bool isSuccess = await _apiService.addUserSession(
        userId: userId,
        sessionId: sessionid,
        sessionName: sessionname,
        actualDuration: actualduration,
        selectedDuration: int.tryParse(selectedduration) ?? 0,
        selectedThreshold: selectedthresholdvalue,
        focusvalue: focusvalue);

    if (!mounted) return;

    if (isSuccess) {
      print("User added successfully!");
    } else {
      print("Failed to add user. Try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    checkSavedData();
    print(widget.controller.text);
    final sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    final getsessionprovider = Provider.of<GetsessionProvider>(context);

    double progress =
        remainingTime / ((int.tryParse(widget.controller.text) ?? 1) * 60);

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
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 210,
                    height: 210,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade800,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(brandPrimaryColor),
                    ),
                  ),
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
                      SizedBox(height: 20),
                      Text("Timer",
                          style: TextStyle(
                              color: textPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Now Playing : ${widget.sessionName}",
                  style: TextStyle(
                      color: textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: Image.asset(
                  'assets/waves.png',
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 30),
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
            Text("Meditation time",
                style: TextStyle(
                    color: textPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
                getsessionprovider.isLoading
                    ? "Loading..."
                    : "${getsessionprovider.totalprogress}",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OnboardingButton(
                    onPressed: () {
                      sessionProvider.stop();
                      stopTimer();
                      addsessionData();
                    },
                    buttonText: 'Stop'),
                OnboardingButton(
                    onPressed: () {
                      getsessionprovider.fetchUser(widget.controller.text);
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
