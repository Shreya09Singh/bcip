// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bciapplication/Screens/progress/breath_exercise_card.dart';
import 'package:bciapplication/Screens/progress/pie_chart.dart';
import 'package:bciapplication/provider/getsession_provider.dart';
import 'package:bciapplication/widget/onboarding_button.dart';

import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:bciapplication/utils/constants.dart';
import 'package:provider/provider.dart';

class DayViewScreen extends StatefulWidget {
  final int progress; // Progress percentage
  final String date; // Date string
  const DayViewScreen({
    Key? key,
    required this.progress,
    required this.date,
  }) : super(key: key);

  @override
  State<DayViewScreen> createState() => _DayViewScreenState();
}

class _DayViewScreenState extends State<DayViewScreen> {
  @override
  Widget build(BuildContext context) {
    final getsessionprovider = Provider.of<GetsessionProvider>(context);

    double greenval = 0;
    int sec = 0;
    String sessionName1 = "";
    String sessionName2 = "";
    int progresss1 = 0;
    int progresss2 = 0;
    double pro = 0;
    if (!getsessionprovider.isLoading &&
        getsessionprovider.user != null &&
        getsessionprovider.user!.sessions.isNotEmpty) {
      greenval =
          getsessionprovider.user!.sessions[0].selectedThreshold.toDouble();
      sec = getsessionprovider.user!.sessions[0].actualDuration;
      // Ensure the index does not exceed the list length
      int sessionIndex = (getsessionprovider.user?.sessions.length ?? 0) > 2
          ? 2
          : (getsessionprovider.user?.sessions.length ?? 0) > 1
              ? 1
              : 0;

// Access session data safely
      progresss1 =
          getsessionprovider.user?.sessions[sessionIndex].actualDuration ?? 0;
      progresss2 =
          getsessionprovider.user?.sessions[sessionIndex].listenDuration ?? 0;

      if (progresss2 > 0) {
        pro = (progresss1.toDouble() /
            progresss2.toDouble()); // Convert to double
      }

      if (getsessionprovider.user!.sessions.length > 1) {
        sessionName1 = getsessionprovider.user!.sessions[0].sessionName;
        sessionName2 = getsessionprovider.user!.sessions[1].sessionName;
      } else {
        sessionName1 = getsessionprovider.user!.sessions[0].sessionName;
        sessionName2 = "No Session Available";
      }
    }

    int guidedsec = progresss1 ~/ 60;
    int remainingSeconds =
        progresss1 % 60; // Correcting leftover seconds calculation
    int unguidedsec = progresss2 ~/ 60;
    int unguidedremainingSeconds = progresss2 % 60;

    int totalguide = guidedsec + unguidedsec;
    int totalremaining = remainingSeconds + unguidedremainingSeconds;

    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF334155),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          fontSize: 18,
                          color: textPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_left,
                              color: Colors.white),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38.withOpacity(0.8),
                                    blurRadius: 20,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            CircularPercentIndicator(
                              radius: 73,
                              lineWidth: 5.0,
                              percent: 1,
                              progressColor: Colors.black,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            CircularPercentIndicator(
                              radius: 66,
                              lineWidth: 13.0,
                              percent: (pro / 100),
                              animation: true,
                              animationDuration: 1200,
                              linearGradient: LinearGradient(colors: [
                                brandPrimaryColor,
                                brandPrimaryColor,
                                Colors.grey,
                                brandPrimaryColor,
                              ]),
                              backgroundColor:
                                  const Color.fromARGB(255, 203, 200, 200),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " ${pro.toInt()}", // Show only rounded integer percentage
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "%",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 165,
                  child: CustomPieChart(
                    redValue: 40,
                    greenValue: greenval,
                    showPercentage: true,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Meditation Level Threshold',
                          style: TextStyle(
                              fontSize: 17,
                              color: textPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const LegendWidget(
                          color: Colors.lightGreen,
                          text: 'Crossed 50 threshold value'),
                      const SizedBox(height: 6),
                      const LegendWidget(
                          color: Colors.red,
                          text: 'Did not cross 50 threshold value'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily session',
                    style: TextStyle(
                        color: brandPrimaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                    width: 95,
                    child: Card(
                      color: brandPrimaryColor,
                      child: Center(
                          child: Text(
                        "$totalguide:$totalremaining min",
                        style: TextStyle(
                            color: textPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                    ),
                  )
                ],
              ),
            ),
            BreathExerciseCard(
              title: sessionName1,
              firstIcon: Icons.mic,
              firstText: 'Guided',
              secondIcon: Icons.alarm,
              secondText: "$guidedsec:$remainingSeconds min",
              textColor: textPrimaryColor,
              cardColor: Colors.blue,
            ),
            const SizedBox(height: 7),
            BreathExerciseCard(
              title: sessionName2,
              firstIcon: Icons.mic_off,
              firstText: 'Un-guided',
              secondIcon: Icons.alarm,
              secondText: "$unguidedsec:$unguidedremainingSeconds min",
              textColor: textPrimaryColor,
              cardColor: Colors.blue,
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: 70,
                width: 320,
                child: Card(
                  color: const Color(0xFF334155),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('My daily Goal',
                                style: TextStyle(
                                    color: textPrimaryColor, fontSize: 17)),
                            Text('10 quiet min',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                            width: 80,
                            child: OnboardingButton(
                                onPressed: () {}, buttonText: 'Edit')),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
