import 'package:bciapplication/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPieChart extends StatelessWidget {
  final double redValue;
  final double greenValue;
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
    return Container(
      width: 150,
      height: 140,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: redValue,
              color: Colors.red,
              radius: radius,
              showTitle: false,
            ),
            PieChartSectionData(
              value: greenValue,
              color: Colors.lightGreen,
              radius: radius,
              title: showPercentage
                  ? "${greenValue.toInt()}%"
                  : "", // Show % only if true
              titleStyle: TextStyle(
                fontSize: 22,
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
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 5),
        Text(text,
            style:
                GoogleFonts.poppins(color: textSecondaryColor, fontSize: 12)),
      ],
    );
  }
}
