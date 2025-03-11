import 'package:bciapplication/Screens/progress/calculation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:bciapplication/Screens/progress/breath_exercise_card.dart';
import 'package:bciapplication/Screens/progress/pie_chart.dart';
import 'package:bciapplication/provider/getsession_provider.dart';
import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:bciapplication/utils/constants.dart';

class DayViewScreen extends StatefulWidget {
  final int progress;
  final String date;

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
    final sessionhelper = SessionHelper(context);
    final getsessionprovider = Provider.of<GetsessionProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.8,
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
                          fontSize: screenWidth * 0.05,
                          color: textPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.chevron_left,
                                color: Colors.white, size: screenWidth * 0.08),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: screenWidth * 0.4,
                                height: screenWidth * 0.4,
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
                                radius: screenWidth * 0.18,
                                lineWidth: 5.0,
                                percent: 1,
                                progressColor: Colors.black,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                              CircularPercentIndicator(
                                radius: screenWidth * 0.16,
                                lineWidth: 13.0,
                                percent: sessionhelper.progress,
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
                                      " ${(sessionhelper.progress * 100).toInt()}",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "%",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.06,
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
                            icon: Icon(Icons.chevron_right,
                                color: Colors.white, size: screenWidth * 0.08),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.40,
                    child: CustomPieChart(
                      redValue: 40,
                      greenValue: sessionhelper.thresholdPercentage,
                      showPercentage: true,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Meditation Level Threshold',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: textPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        LegendWidget(
                            color: Colors.lightGreen,
                            text: 'Crossed 50 threshold value'),
                        SizedBox(height: screenHeight * 0.01),
                        LegendWidget(
                            color: Colors.red,
                            text: 'Did not cross 50 threshold value'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daily session',
                      style: TextStyle(
                        color: brandPrimaryColor,
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      color: brandPrimaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        child: Text(
                          '${sessionhelper.formattedTime} min',
                          style: TextStyle(
                            color: textPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              BreathExerciseCard(
                title: sessionhelper.sessionName1,
                firstIcon: Icons.mic,
                firstText: 'Guided',
                secondIcon: Icons.alarm,
                secondText: '${sessionhelper.guidedTime} sec',
                textColor: textPrimaryColor,
                cardColor: Colors.blue,
              ),
              SizedBox(height: screenHeight * 0.015),
              BreathExerciseCard(
                title: sessionhelper.sessionName2,
                firstIcon: Icons.mic_off,
                firstText: 'Un-guided',
                secondIcon: Icons.alarm,
                secondText: '${sessionhelper.unguidedTime} sec',
                textColor: textPrimaryColor,
                cardColor: Colors.blue,
              ),
              SizedBox(height: screenHeight * 0.015),
              SizedBox(
                width: screenWidth * 0.80,
                child: Card(
                  color: const Color(0xFF334155),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('My daily Goal',
                                style: TextStyle(
                                    color: textPrimaryColor,
                                    fontSize: screenWidth * 0.040)),
                            Text('10 quiet min',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                    fontSize: screenWidth * 0.050)),
                          ],
                        ),
                        SizedBox(
                            height: screenHeight * 0.056,
                            width: screenWidth * 0.25,
                            child: OnboardingButton(
                                onPressed: () {}, buttonText: 'Edit')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
