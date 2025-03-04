import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FrequencyVisualizer extends StatefulWidget {
  @override
  _FrequencyVisualizerState createState() => _FrequencyVisualizerState();
}

class _FrequencyVisualizerState extends State<FrequencyVisualizer> {
  double sliderValue = 50; // Slider value (1-100)
  List<double> frequencyData = [];

  @override
  void initState() {
    super.initState();
    _generateFrequencyData();
  }

  void _generateFrequencyData() {
    // Generate random frequency data based on slider value
    Random random = Random();
    frequencyData =
        List.generate(50, (index) => random.nextDouble() * sliderValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Slider
          Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Column(
              children: [
                // Text(
                //   "Threshold: ${sliderValue.toInt()}",
                //   style: TextStyle(color: Colors.white, fontSize: 18),
                // ),

                Slider(
                  value: sliderValue,
                  min: 1,
                  max: 100,
                  label: sliderValue.toInt().toString(),
                  divisions: 100,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                      _generateFrequencyData(); // Update frequency data
                    });
                  },
                ),
              ],
            ),
          ),
          // Frequency Chart
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomPaint(
                painter: FrequencyPainter(frequencyData),
                child: Container(), // Placeholder for painting
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FrequencyPainter extends CustomPainter {
  final List<double> frequencyData;

  FrequencyPainter(this.frequencyData);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = textSecondaryColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double barWidth = size.width / frequencyData.length;

    // Scaling factor to reduce the height of the bars
    // Adjust this value to control the height

    for (int i = 0; i < frequencyData.length; i++) {
      final double x = i * barWidth;

      // Apply the scaling factor to reduce the height of the bars
      final double y = size.height - (frequencyData[i] / 100) * size.height;

      canvas.drawLine(Offset(x, size.height), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redraw whenever frequency data changes
  }
}
