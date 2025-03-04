// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Widget targetScreen;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.targetScreen,
    required this.screenWidth,
    required this.screenHeight,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => targetScreen,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: brandPrimaryColor, // Button color
          foregroundColor: backgroundWhiteColor, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0, // Fixed horizontal padding
            vertical: 12.0, // Reduced vertical padding
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton2({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: 105,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Button color
          foregroundColor: textColor, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7), // Round corners
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0, // Fixed horizontal padding
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
