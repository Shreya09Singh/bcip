import 'package:bciapplication/provider/onboarding_provider.dart';
import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/utils/string.dart';
import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.55,
            decoration: BoxDecoration(
              color: backgroundLightBlueColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(screenWidth * 0.6),
                bottomRight: Radius.circular(screenWidth * 0.6),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Row(
                        children: [
                          Consumer<OnboardingProvider>(
                            builder: (context, progressProvider, child) {
                              final currentIndex =
                                  progressProvider.currentIndex;
                              return CircleAvatar(
                                radius: screenWidth * 0.04,
                                backgroundColor: index == currentIndex
                                    ? brandPrimaryColor
                                    : textPrimaryColor,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: index == currentIndex
                                        ? textPrimaryColor
                                        : brandPrimaryColor,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (index < 4)
                            Container(
                              width: screenWidth * 0.1,
                              height: 2,
                              color: backgroundWhiteColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: screenWidth * 0.08,
                    top: screenHeight * 0.12,
                    child: Text(
                      'BCI\nAPP',

                      // AppString.bciapp,
                      style: TextStyle(
                          fontSize: 45,
                          height: 1.1,
                          fontWeight: FontWeight.w900),
                    )),
                Positioned(
                  top: screenHeight * 0.19,
                  left: screenWidth * 0.17,
                  child: Consumer<OnboardingProvider>(
                      builder: (context, provider, child) {
                    return Image.asset(
                      AppAssets.images[provider.currentIndex],
                      width: screenWidth * 0.7,
                    );
                  }),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, top: screenHeight * 0.02),
              child: Text(
                AppString.activities,
                style: TextStyle(
                  color: textPrimaryColor,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
            child: SizedBox(
              height: screenHeight * 0.17,
              width: screenWidth,
              child: Card(
                color: backgroundWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.016, top: screenHeight * 0.02),
                  child: Row(
                    children: [
                      Icon(Icons.lightbulb_sharp,
                          size: screenWidth * 0.14, color: Colors.yellow),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              AppString.title,
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              minFontSize: 12,
                            ),
                            SizedBox(height: screenHeight * 0.009),
                            Consumer<OnboardingProvider>(
                                builder: (context, provider, child) {
                              return AutoSizeText(
                                AppString.cardContents[provider.currentIndex],
                                style: TextStyle(fontSize: screenWidth * 0.04),
                                maxLines: 3,
                                minFontSize: 14,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OnboardingButton(
                onPressed: () {},
                buttonText: AppString.skip,
              ),
              Consumer<OnboardingProvider>(builder: (context, provider, child) {
                return OnboardingButton(
                  onPressed: () {
                    provider.nextStep(context);
                  },
                  buttonText: AppString.next,
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}
