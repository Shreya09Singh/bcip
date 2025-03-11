import 'package:bciapplication/Screens/progress/CustomChart.dart';
import 'package:bciapplication/Screens/progress/calculation.dart';
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
  @override
  Widget build(BuildContext context) {
    SessionHelper sessionhelper = SessionHelper(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: screenHeight * 0.25,
                  width: screenWidth * 0.8,
                  child: WeekChart(
                      chartData: sessionhelper.chartdata,
                      chartType: ChartType.line),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.38,
                    child: CustomPieChart(
                      redValue: 50,
                      greenValue: sessionhelper.thresholdPercentage,
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
                              fontSize: screenWidth * 0.045,
                              color: textPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        LegendWidget(
                            color: Colors.lightGreen,
                            text: 'Crossed 50 threshold value'),
                        SizedBox(height: screenHeight * 0.007),
                        LegendWidget(
                            color: Colors.red,
                            text: 'Did not cross 50 threshold value'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.010),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            fontSize: screenWidth * 0.030),
                        children: [
                          TextSpan(
                              text: "On average, you practiced mindfulness "),
                          TextSpan(
                            text: "11% ",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: "less this month compared to last."),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressStat(
                          value: sessionhelper.averagemonthprogress
                              .round()
                              .toString(),
                          label: "min/day",
                          subLabel: "This month",
                          valueColor: brandPrimaryColor,
                          labelColor: textPrimaryColor,
                          subLabelColor: textSecondaryColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.008),
                          decoration: BoxDecoration(
                            color: brandPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.red, size: screenWidth * 0.04),
                              Text(
                                " 11%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.035),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.004),
                    LinearProgressIndicator(
                      value: sessionhelper.averagemonthprogress / 100,
                      backgroundColor: Colors.grey.shade300,
                      color: brandPrimaryColor,
                      minHeight: screenHeight * 0.01,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    ProgressStat(
                      value: sessionhelper.previoustime.toString(),
                      label: "min/day",
                      subLabel: "Previous month",
                      valueColor: brandPrimaryColor,
                      labelColor: textPrimaryColor,
                      subLabelColor: textSecondaryColor,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    LinearProgressIndicator(
                      value: sessionhelper.listenTime / 100,
                      backgroundColor: Colors.grey.shade300,
                      color: brandPrimaryColor,
                      minHeight: screenHeight * 0.01,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                height: screenHeight * 0.09,
                width: screenWidth * 0.9,
                child: Card(
                  color: Color(0xFF334155),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Goal Streak',
                            style: TextStyle(
                                color: textPrimaryColor,
                                fontSize: screenWidth * 0.035),
                          ),
                          Text(
                            '10 days in a row',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textPrimaryColor,
                                fontSize: screenWidth * 0.04),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.015),
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(28, (index) {
                              return Container(
                                width: screenWidth * 0.005,
                                height: screenHeight * 0.013,
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.004),
                                color: (index > 2 && index < 17)
                                    ? brandPrimaryColor
                                    : textSecondaryColor,
                              );
                            })),
                      )
                    ],
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
