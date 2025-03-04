import 'package:bciapplication/Screens/registration/registration_screen.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/utils/string.dart';
import 'package:bciapplication/widget/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Background image with overlay
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.welcomeimg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color:

                      // ignore: deprecated_member_use
                      backgroundBlackColor
                          // ignore: deprecated_member_use
                          .withOpacity(0.6),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome Text
                  Spacer(flex: 1),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      // ignore: deprecated_member_use
                      textScaleFactor: 0.8,
                      AppString.welcome,
                      style: TextStyle(
                        color: brandPrimaryColor, // Text color
                        fontSize: screenWidth * 0.15, // Dynamic font size
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(flex: 10),
                  // Subtitle Text
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Text(
                      AppString.welcomemessage,
                      style: TextStyle(
                        color: textPrimaryColor,
                        fontSize: screenWidth * 0.037, // Dynamic font size
                        fontWeight: FontWeight.w300,
                        height: 1.5, // Line height for better readability
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(flex: 1),
                  // Get Started Button with shadow
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                        label: AppString.getstart,
                        targetScreen: RegistrationScreen(),
                        screenWidth: screenWidth,
                        screenHeight: screenHeight),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
