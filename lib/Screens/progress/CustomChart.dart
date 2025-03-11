import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Data Model
class WeekData {
  final String day; // Day of the week
  final num value; // Value associated with that day

  WeekData(this.day, this.value);
}

// Enum for different chart types
enum ChartType { column, line }

class WeekChart extends StatelessWidget {
  final List<WeekData> chartData; // Accepting chart data as a parameter
  final ChartType chartType; // Accepting chart type as a parameter

  // Constructor
  WeekChart({required this.chartData, required this.chartType});

  @override
  Widget build(BuildContext context) {
    // Determine which series to use based on the chartType
    CartesianSeries<WeekData, String> series;

    switch (chartType) {
      case ChartType.column:
        series = ColumnSeries<WeekData, String>(
          dataSource: chartData,
          xValueMapper: (WeekData data, _) => data.day,
          yValueMapper: (WeekData data, _) => data.value,
          color: Colors.blue,
        );
        break;
      case ChartType.line:
        series = LineSeries<WeekData, String>(
          dataSource: chartData,
          xValueMapper: (WeekData data, _) => data.day,
          yValueMapper: (WeekData data, _) => data.value,
          color: brandPrimaryColor,
        );
        break;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF334155),
          borderRadius: BorderRadius.circular(
              20), // Border radius for the chart container
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Jan 22-29 2025',
                      style: TextStyle(
                          fontSize: 16,
                          color: textPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 160,
              child: SfCartesianChart(
                plotAreaBorderColor: Colors.transparent,
                primaryYAxis: NumericAxis(
                  maximum: 100,
                  minimum: 0,
                  interval: 20,
                  labelStyle: TextStyle(
                    color: Colors.white, // Color for Y-axis labels
                    fontSize: 10, // Optional: Set font size
                  ),
                  axisLine: AxisLine(color: Colors.transparent),
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                  minorGridLines: MinorGridLines(color: Colors.transparent),
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                    color: Colors.white, // Color for X-axis labels
                    fontSize: 10, // Optional: Set font size
                  ),
                  axisLine: AxisLine(color: Colors.transparent),
                  majorGridLines: MajorGridLines(color: Colors.transparent),
                ),
                series: [
                  series, // Adding the selected series based on chartType
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
