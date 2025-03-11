import 'package:bciapplication/Screens/progress/CustomChart.dart';
import 'package:bciapplication/Screens/progress/calculation.dart';
import 'package:bciapplication/Screens/progress/pie_chart.dart';
import 'package:bciapplication/provider/getsession_provider.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WeekViewScreen extends StatefulWidget {
  const WeekViewScreen({super.key});

  @override
  State<WeekViewScreen> createState() => _WeekViewScreenState();
}

class _WeekViewScreenState extends State<WeekViewScreen> {
  @override
  Widget build(BuildContext context) {
    final sessionhelper = SessionHelper(context);
    final getsessionprovider = Provider.of<GetsessionProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.9,
                  child: WeekChart(
                    chartData: sessionhelper.chartdata,
                    chartType: ChartType.column,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.35,
                    child: CustomPieChart(
                      redValue: 50,
                      greenValue: sessionhelper.thresholdPercentage,
                      showPercentage: true,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
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
                        SizedBox(height: screenHeight * 0.008),
                        LegendWidget(
                            color: Colors.red,
                            text: 'Did not cross 50 threshold value'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                "Weekly Progress",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: brandPrimaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: screenWidth * 0.030,
                  ),
                  children: [
                    TextSpan(text: "On average, you practiced mindfulness "),
                    TextSpan(
                      text: sessionhelper.overThresholdCount.toString(),
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: " % more this week compared to last."),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProgressStat(
                    value: sessionhelper.listenTime.toString(),
                    label: "min/day",
                    subLabel: "This week",
                    valueColor: brandPrimaryColor,
                    labelColor: textPrimaryColor,
                    subLabelColor: textSecondaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.005),
                    decoration: BoxDecoration(
                      color: brandPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_drop_up,
                            color: Colors.lightGreen, size: screenWidth * 0.05),
                        Text(
                          " 4%",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.006),
              LinearProgressIndicator(
                value: sessionhelper.listenTime / 100,
                backgroundColor: Colors.grey.shade300,
                color: brandPrimaryColor,
                minHeight: screenHeight * 0.008,
                borderRadius: BorderRadius.circular(4),
              ),
              SizedBox(height: screenHeight * 0.015),
              ProgressStat(
                value: sessionhelper.previoustime.toString(),
                label: "min/day",
                subLabel: "Previous week",
                valueColor: brandPrimaryColor,
                labelColor: textPrimaryColor,
                subLabelColor: textSecondaryColor,
              ),
              SizedBox(height: screenHeight * 0.005),
              LinearProgressIndicator(
                value: sessionhelper.previoustime / 100,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blue.shade400,
                minHeight: screenHeight * 0.008,
                borderRadius: BorderRadius.circular(4),
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                height: screenHeight * 0.1,
                width: screenWidth * 0.9,
                child: Card(
                  color: Color(0xFF334155),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Goal Streak',
                              style: TextStyle(
                                  color: textPrimaryColor,
                                  fontSize: screenWidth * 0.045),
                            ),
                            Text(
                              '3 days in a row',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: textPrimaryColor,
                                  fontSize: screenWidth * 0.05),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(7, (index) {
                              return Container(
                                width: screenWidth * 0.008,
                                height: screenHeight * 0.03,
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.005),
                                color: (index > 2 && index < 6)
                                    ? brandPrimaryColor
                                    : textSecondaryColor,
                              );
                            })),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.1,
            color: valueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: screenWidth * 0.015),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: screenWidth * 0.045, color: labelColor)),
            Text(subLabel,
                style: TextStyle(
                    fontSize: screenWidth * 0.035, color: subLabelColor)),
          ],
        ),
      ],
    );
  }
}
