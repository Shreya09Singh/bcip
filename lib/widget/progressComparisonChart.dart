import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComparisonChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            color: greybackgroundColor, // Dark theme background
            borderRadius: BorderRadius.circular(10),
            // Outer border
          ),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_back_ios, color: Colors.white),
                Text(
                  "Feb 10-17, 2025",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 180,
              child: SfCartesianChart(
                plotAreaBorderColor: greybackgroundColor,
                backgroundColor: greybackgroundColor,
                primaryXAxis: CategoryAxis(
                  labelStyle: const TextStyle(color: Colors.white),
                  majorGridLines: const MajorGridLines(
                      width: 0, color: greybackgroundColor),
                ),
                primaryYAxis: NumericAxis(
                  maximum: 12,
                  minimum: 2,
                  interval: 2,
                  labelStyle: const TextStyle(color: Colors.white),
                  majorGridLines: const MajorGridLines(
                      width: 0.5, color: greybackgroundColor),
                  axisLine:
                      const AxisLine(width: 1, color: greybackgroundColor),
                ),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                tooltipBehavior: TooltipBehavior(enable: true),

                // 🎯 Bar Series Data
                series: [
                  ColumnSeries<TaskData, String>(
                    name: "Complete",
                    color: brandPrimaryColor,
                    dataSource: getTaskData(),
                    xValueMapper: (TaskData data, _) => data.day,
                    yValueMapper: (TaskData data, _) => data.completed,
                    width: 0.5,
                  ),
                  ColumnSeries<TaskData, String>(
                    name: "Ongoing",
                    color: textPrimaryColor,
                    dataSource: getTaskData(),
                    xValueMapper: (TaskData data, _) => data.day,
                    yValueMapper: (TaskData data, _) => data.ongoing,
                    width: 0.5,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  // 📌 Sample Data for Tasks
  List<TaskData> getTaskData() {
    return [
      TaskData("Sun", 7, 4),
      TaskData("Mon", 5, 7),
      TaskData("Tue", 10, 9),
      TaskData("Wed", 3, 6),
      TaskData("Thu", 8, 7),
      TaskData("Fri", 12, 9),
      TaskData("Sat", 4, 3),
    ];
  }
}

// 📌 Task Data Model
class TaskData {
  final String day;
  final int completed;
  final int ongoing;

  TaskData(this.day, this.completed, this.ongoing);
}
