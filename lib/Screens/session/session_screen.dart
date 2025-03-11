import 'dart:async';

import 'package:bciapplication/widget/customSnakebar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bciapplication/Screens/progress/TabBar_screen.dart';
import 'package:bciapplication/Screens/session/statCard.dart';
import 'package:bciapplication/provider/session_provider.dart';
import 'package:bciapplication/provider/timer_provider.dart';
import 'package:bciapplication/provider/getsession_provider.dart';
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
  Timer? timer;
  int remainingTime = 0;
  int listentime = 0;
  double progress = 1.0;
  // int totaltime = int.parse(widget.controller.text);

  @override
  void initState() {
    super.initState();
    startTimer();
    getUserData();
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
            progress = remainingTime / seconds;
          });
        } else {
          timer.cancel();
        }
      });
    }
  }

  void stopTimer() {
    timer?.cancel();
    int totaltime =
        (int.tryParse(widget.controller.text) ?? 0) * 60; // Convert min to sec
    int elapshedtime = totaltime - remainingTime;

    if (mounted) {
      // Only update UI if the widget is still in the tree
      setState(() {
        listentime = elapshedtime;
      });
    }
// Refresh UI
    print('listentime');
    print(listentime);
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    if (userId != null) {
      debugPrint("User ID: $userId");
    }
  }

  Future<void> addsessionData() async {
    final timerprovider = Provider.of<TimerProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("User ID not found. Please log in again.")),
      );
      return;
    }

    bool isSuccess = await _apiService.addUserSession(
      userId: userId,
      sessionId: widget.sessionId,
      sessionName: widget.sessionName,
      actualDuration: listentime,
      selectedDuration: int.tryParse(widget.controller.text) ?? 0,
      selectedThreshold: widget.thresholdvalue,
      focusvalue: timerprovider.randomNumbers,
    );

    if (!mounted) return;

    CustomSnackBar.show(
        context,
        isSuccess
            ? "Session added successfully!"
            : "Failed to add session. Try again.");
  }

  @override
  Widget build(BuildContext context) {
    final sessionProvider =
        Provider.of<SessionProvider>(context, listen: false);
    final getsessionprovider = Provider.of<GetsessionProvider>(context);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05), // 5% padding
            child: Column(
              children: [
                SizedBox(height: height * 0.01), // 1% height
                Align(
                  alignment: Alignment.topCenter,
                  child: Consumer<TimerProvider>(
                      builder: (context, provider, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.55, // 55% of screen width
                          height: width * 0.55, // Maintain circular shape
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey.shade800,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                brandPrimaryColor),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: width * 0.1, // Dynamic font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            const Text("Timer",
                                style: TextStyle(
                                    color: textPrimaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Now Playing : ${widget.sessionName}",
                      style: TextStyle(
                          color: textPrimaryColor,
                          fontSize: width * 0.04, // Scalable font
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.07, // 7% of screen height
                  width: double.infinity,
                  child: Image.asset(
                    'assets/waves.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height * 0.04),
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
                        timeColor: Colors.green),
                  ],
                ),
                SizedBox(height: height * 0.04),
                const Text("Meditation time",
                    style: TextStyle(
                        color: textPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Consumer<TimerProvider>(builder: (context, timer, child) {
                  return Text(timer.currentRandomNumber.toString(),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold));
                }),
                SizedBox(height: height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OnboardingButton(
                        onPressed: () {
                          stopTimer();
                          sessionProvider.pauseAudio();
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
                        buttonText: 'Next'),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
