import 'package:bciapplication/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPieChart extends StatelessWidget {
  final int redValue;
  final int greenValue;
  final double radius;
  final bool showPercentage;

  const CustomPieChart({
    Key? key,
    required this.redValue,
    required this.greenValue,
    this.radius = 60, // Default radius
    this.showPercentage = false, // Hide percentage by default
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double adjustedRadius = screenWidth * 0.15; // Adjust radius dynamically

    return Container(
      width: screenWidth * 0.4, // 40% of screen width
      height: screenWidth * 0.35, // 35% of screen width
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: redValue.toDouble(),
              color: Colors.red,
              radius: adjustedRadius,
              showTitle: false,
            ),
            PieChartSectionData(
              value: greenValue.toDouble(),
              color: Colors.lightGreen,
              radius: adjustedRadius,
              title: showPercentage ? "${greenValue}%" : "",
              titleStyle: TextStyle(
                fontSize: screenWidth * 0.05, // Responsive font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 0,
        ),
      ),
    );
  }
}

class LegendWidget extends StatelessWidget {
  final Color color;
  final String text;

  const LegendWidget({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: screenWidth * 0.04, // Responsive square size
          height: screenWidth * 0.04,
          color: color,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: textSecondaryColor,
              fontSize: screenWidth * 0.03, // Responsive font size
            ),
          ),
        ),
      ],
    );
  }
}
