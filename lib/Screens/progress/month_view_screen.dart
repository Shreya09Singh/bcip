import 'dart:math';

import 'package:bciapplication/Screens/progress/CustomChart.dart';
import 'package:bciapplication/Screens/progress/pie_chart.dart';
import 'package:bciapplication/Screens/progress/week_view_screen.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class MonthViewScreen extends StatefulWidget {
  const MonthViewScreen({super.key});

  @override
  State<MonthViewScreen> createState() => _MonthViewScreenState();
}

class _MonthViewScreenState extends State<MonthViewScreen> {
  final List<WeekData> chartData = [
    WeekData('Sun', 10),
    WeekData('Mon', 3),
    WeekData('Tue', 9),
    WeekData('Wed', 6),
    WeekData('Thu', 3),
    WeekData('Fri', 4),
    WeekData('Sat', 5),
  ];

  late List<WeekData> modifiedChartData;

  @override
  void initState() {
    super.initState();
    // Modify chartData to generate random values for x-axis
    modifiedChartData = chartData.map((data) {
      int randomNumber =
          Random().nextInt(30) + 1; // Random number between 1 and 30
      return WeekData(randomNumber.toString(),
          data.value); // Using random number for x-axis
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 240,
                  width: 325,
                  child: WeekChart(
                      chartData: modifiedChartData, chartType: ChartType.line)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 165,
                  child: CustomPieChart(
                    redValue: 65,
                    greenValue: 35,
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
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly progress",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: brandPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: textSecondaryColor, fontSize: 12),
                          children: [
                            TextSpan(
                                text: "On average, you practiced mindfulness "),
                            TextSpan(
                              text: "11% ",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "less this month compared to last."),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProgressStat(
                            value: "6",
                            label: "min/day",
                            subLabel: "This month",
                            valueColor: brandPrimaryColor,
                            labelColor: textPrimaryColor,
                            subLabelColor: textSecondaryColor,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              color: brandPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.red, size: 18),
                                Text(
                                  " 11%",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value:
                            6 / 10, // Adjust the ratio based on maximum value
                        backgroundColor: Colors.grey.shade300,
                        color: brandPrimaryColor,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      SizedBox(height: 12),
                      ProgressStat(
                        value: "12",
                        label: "min/day",
                        subLabel: "previous month",
                        valueColor: brandPrimaryColor,
                        labelColor: textPrimaryColor,
                        subLabelColor: textSecondaryColor,
                      ),
                      SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: 7 / 10, // Adjust based on actual max value
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.blue.shade400,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ])),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                  height: 66,
                  width: 350,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Goal Streak',
                                style: TextStyle(
                                    color: textPrimaryColor, fontSize: 14),
                              ),
                              Text(
                                '10 days in a row',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(28, (index) {
                                return Container(
                                  width: 2.3, // Width of each stripe
                                  height: 12, // Height of the stripes
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 1.4), // Space between stripes
                                  // Alternating colors
                                  color: (index > 2 && index < 17)
                                      ? brandPrimaryColor
                                      : textSecondaryColor,
                                );
                              })),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
