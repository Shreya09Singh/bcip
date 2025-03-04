// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bciapplication/Screens/progress/breath_exercise_card.dart';
import 'package:bciapplication/Screens/progress/pie_chart.dart';
import 'package:bciapplication/widget/onboarding_button.dart';

import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:bciapplication/utils/constants.dart';

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
    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF334155)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Feb 02, 2025',
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
                          icon: Icon(Icons.chevron_left, color: Colors.white),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 150, // Slightly bigger than the indicator
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38
                                        .withOpacity(0.8), // Glowing effect
                                    blurRadius: 20, // How much blur
                                    spreadRadius:
                                        8, // How far the shadow spreads
                                  ),
                                ],
                              ),
                            ),
                            // Outer Circle
                            CircularPercentIndicator(
                              radius: 73,
                              lineWidth: 5.0,
                              percent: 1, // Always full to create an outer ring

                              // backgroundColor: Colors.white.withOpacity(0.2),
                              progressColor: Colors.black,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            // Inner Circle (Actual Progress)
                            CircularPercentIndicator(
                              // fillColor: Colors.black,
                              radius: 66,
                              lineWidth: 13.0,
                              percent: widget.progress / 100,
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
                              // progressColor: Colors.blueAccent,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${widget.progress}",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
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
                          icon: Icon(Icons.chevron_right, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 165,
                  child: CustomPieChart(
                    redValue: 40,
                    greenValue: 60,
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
                      SizedBox(
                        height: 20,
                      ),
                      LegendWidget(
                          color: Colors.lightGreen,
                          text: 'crossed 50 threshold value'),
                      SizedBox(
                        height: 6,
                      ),
                      LegendWidget(
                          color: Colors.red,
                          text: ' did not cross 50 threshold value'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
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
                        '4:27 min',
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
              title: "Lion's Breath",
              firstIcon: Icons.mic,
              firstText: 'Guided',
              secondIcon: Icons.alarm,
              secondText: '02:27 min',
              textColor: textPrimaryColor,
              cardColor: Colors.blue,
            ),
            SizedBox(
              height: 7,
            ),
            BreathExerciseCard(
              title: "Gentle Rain",
              firstIcon: Icons.mic_off,
              firstText: 'Un-guided',
              secondIcon: Icons.alarm,
              secondText: '02:00 min',
              textColor: textPrimaryColor,
              cardColor: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 70,
                width: 320,
                child: Card(
                  color: Color(0xFF334155),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'My daily Goal',
                              style: TextStyle(
                                  color: textPrimaryColor, fontSize: 17),
                            ),
                            Text(
                              '10 quiet min',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textPrimaryColor,
                                  fontSize: 20),
                            ),
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
                ))
          ],
        ),
      ),
    );
  }
}
