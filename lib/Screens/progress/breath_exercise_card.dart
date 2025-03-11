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
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05), // Dynamic padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenWidth * 0.2, // 20% of screen width
            width: screenWidth * 0.2,
            child: Card(
              color: cardColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                child: Image.network(
                  'https://i.ytimg.com/vi/jv_uolrknjA/maxresdefault.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03), // Dynamic spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize:
                        screenWidth * 0.045, // Adjust based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02), // Dynamic spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GuidedWidget(
                        icon: firstIcon,
                        textColor: textColor,
                        text: firstText,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    Expanded(
                      child: GuidedWidget(
                        icon: secondIcon,
                        textColor: textColor,
                        text: secondText,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// GuidedWidget remains the same but with dynamic font size
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
    this.fontSize = 13,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: brandPrimaryColor,
          size: fontSize * 1.5, // Adjust icon size dynamically
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
            overflow: TextOverflow.ellipsis, // Prevents overflow
          ),
        ),
      ],
    );
  }
}
