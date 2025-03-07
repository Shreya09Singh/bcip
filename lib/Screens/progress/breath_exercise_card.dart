import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class BreathExerciseCard extends StatelessWidget {
  final String title;
  final IconData firstIcon;
  final String firstText;
  final IconData secondIcon;
  final String secondText;
  final Color textColor;
  final Color cardColor;

  const BreathExerciseCard({
    Key? key,
    required this.title,
    required this.firstIcon,
    required this.firstText,
    required this.secondIcon,
    required this.secondText,
    required this.textColor,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          SizedBox(
            height: 90,
            width: 90,
            child: Card(
              color: cardColor, // Dynamic card color
              child: Image.network(
                  fit: BoxFit.cover,
                  'https://i.ytimg.com/vi/jv_uolrknjA/maxresdefault.jpg'),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to left
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  GuidedWidget(
                    icon: firstIcon,
                    textColor: textColor,
                    text: firstText,
                  ),
                  SizedBox(width: 10),
                  GuidedWidget(
                    icon: secondIcon,
                    textColor: textColor,
                    text: secondText,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// GuidedWidget remains the same
class GuidedWidget extends StatelessWidget {
  final IconData icon;
  final Color textColor;
  final String text;
  final double fontSize;

  const GuidedWidget({
    Key? key,
    required this.icon,
    required this.textColor,
    required this.text,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: brandPrimaryColor,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
