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
    return Column(
      children: [
        Image.asset(
          imagePath,
        ), // Image
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(color: Colors.white70), // Adjust text color
        ),
        SizedBox(height: 7),
        Text(
          time,
          style: TextStyle(
            color: timeColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
