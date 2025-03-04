import 'package:bciapplication/Screens/progress/CustomChart.dart';

import 'package:bciapplication/Screens/progress/pie_chart.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekViewScreen extends StatefulWidget {
  const WeekViewScreen({super.key});

  @override
  State<WeekViewScreen> createState() => _WeekViewScreenState();
}

class _WeekViewScreenState extends State<WeekViewScreen> {
  final List<WeekData> chartData = [
    WeekData('Sun', 10),
    WeekData('Mon', 3),
    WeekData('Tue', 9),
    WeekData('Wed', 6),
    WeekData('Thu', 3),
    WeekData('Fri', 4),
    WeekData('Sat', 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 240,
                  width: 325,
                  child: WeekChart(
                      chartData: chartData, chartType: ChartType.column)),
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
                    greenValue: 64,
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
                              text: "4% ",
                              style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "more this week compared to last."),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProgressStat(
                            value: "9",
                            label: "min/day",
                            subLabel: "This week",
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
                                Icon(Icons.arrow_drop_up,
                                    color: Colors.lightGreen, size: 18),
                                Text(
                                  " 4%",
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
                            9 / 10, // Adjust the ratio based on maximum value
                        backgroundColor: Colors.grey.shade300,
                        color: brandPrimaryColor,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      SizedBox(height: 12),
                      ProgressStat(
                        value: "7",
                        label: "min/day",
                        subLabel: "previous week",
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
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                  height: 80,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Goal Streak',
                                style: TextStyle(
                                    color: textPrimaryColor, fontSize: 17),
                              ),
                              Text(
                                '3 days in a row',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textPrimaryColor,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(7, (index) {
                                return Container(
                                  width: 3, // Width of each stripe
                                  height: 20, // Height of the stripes
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 2), // Space between stripes
                                  // Alternating colors
                                  color: (index > 2 && index < 6)
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

class ProgressStat extends StatelessWidget {
  final String value;
  final String label;
  final String subLabel;
  final Color valueColor;
  final Color labelColor;
  final Color subLabelColor;

  const ProgressStat({
    Key? key,
    required this.value,
    required this.label,
    required this.subLabel,
    required this.valueColor,
    required this.labelColor,
    required this.subLabelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 42,
            color: valueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 7),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                color: labelColor,
              ),
            ),
            Text(
              subLabel,
              style: TextStyle(
                fontSize: 13,
                color: subLabelColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
