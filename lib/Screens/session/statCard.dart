import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final Color timeColor;

  const StatCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.timeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: screenWidth * 0.2, // 20% of screen width
          height: screenWidth * 0.2, // Keep square aspect ratio
          fit: BoxFit.contain,
        ),
        SizedBox(height: screenHeight * 0.015), // Responsive spacing
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: screenWidth * 0.04, // Scalable font size
          ),
        ),
        SizedBox(height: screenHeight * 0.01), // Responsive spacing
        Text(
          time,
          style: TextStyle(
            color: timeColor,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045, // Scalable font size
          ),
        ),
      ],
    );
  }
}
