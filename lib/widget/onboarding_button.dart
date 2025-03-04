import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final String buttonText; // Added text parameter

  const OnboardingButton(
      {Key? key, required this.onPressed, required this.buttonText, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              brandPrimaryColor, // Button color (you can change this)
          foregroundColor: backgroundWhiteColor, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Round corners
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0, // Fixed horizontal padding
            vertical: 12.0, // Reduced vertical padding
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText, // Use the passed buttonText
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
