import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BrainwaveGraph extends StatefulWidget {
  @override
  _BrainwaveGraphState createState() => _BrainwaveGraphState();
}

class _BrainwaveGraphState extends State<BrainwaveGraph> {
  late List<GraphData> chartData;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime(2025, 2, 22);
    chartData = getGraphData();
  }

  List<GraphData> getGraphData() {
    return [
      GraphData(0, 10, 12, 5),
      GraphData(1, 15, 14, 8),
      GraphData(2, 20, 18, 10),
      GraphData(3, 25, 22, 15),
      GraphData(4, 30, 28, 18),
      GraphData(5, 40, 35, 20),
      GraphData(6, 50, 38, 22),
      GraphData(7, 60, 45, 25),
      GraphData(8, 70, 48, 28),
      GraphData(9, 85, 55, 30),
      GraphData(10, 100, 60, 35),
    ];
  }

  void changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header with Date and Navigation Arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left, color: Colors.white),
                  onPressed: () => changeDate(-1),
                ),
                Text(
                  '${selectedDate.toLocal().month}/${selectedDate.day}, ${selectedDate.year}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right, color: Colors.white),
                  onPressed: () => changeDate(1),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Line Chart
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                backgroundColor: Color(0xFF1E293B),
                primaryXAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Time (s)',
                      textStyle: TextStyle(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'µV', textStyle: TextStyle(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  minimum: 0,
                  maximum: 100,
                  interval: 20,
                ),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(color: Colors.white),
                ),
                series: <LineSeries<GraphData, int>>[
                  LineSeries<GraphData, int>(
                    name: 'Alpha',
                    dataSource: chartData,
                    xValueMapper: (GraphData data, _) => data.time,
                    yValueMapper: (GraphData data, _) => data.alpha,
                    color: Colors.pinkAccent,
                    markerSettings: MarkerSettings(isVisible: false),
                  ),
                  LineSeries<GraphData, int>(
                    name: 'Beta',
                    dataSource: chartData,
                    xValueMapper: (GraphData data, _) => data.time,
                    yValueMapper: (GraphData data, _) => data.beta,
                    color: Colors.lightGreenAccent,
                    markerSettings: MarkerSettings(isVisible: false),
                  ),
                  LineSeries<GraphData, int>(
                    name: 'Gamma',
                    dataSource: chartData,
                    xValueMapper: (GraphData data, _) => data.time,
                    yValueMapper: (GraphData data, _) => data.gamma,
                    color: Colors.blueAccent,
                    markerSettings: MarkerSettings(isVisible: false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GraphData {
  final int time;
  final double alpha;
  final double beta;
  final double gamma;

  GraphData(this.time, this.alpha, this.beta, this.gamma);
}
