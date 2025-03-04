import 'package:bciapplication/Screens/registration/verification_screen.dart';
import 'package:bciapplication/services/api/API_services.dart';

import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/utils/string.dart';
import 'package:bciapplication/widget/custom_button.dart';
import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final APIService _apiService = APIService();

  Future<void> _sendOtp() async {
    String phoneNumber = _phoneController.text.trim();

    if (!mounted) return;
    if (phoneNumber.isNotEmpty) {
      _apiService.generateOtp(phoneNumber);
      print('opt send successfully!');
    } else {
      print("Please enter a valid phone number");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlackColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double screenHeight = constraints.maxHeight;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Center(
                      child: Image.asset(
                        AppAssets.registrationimg,
                        width: screenWidth * 0.6,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.055),
                    FittedBox(
                      child: Text(
                        AppString.registration,
                        style: TextStyle(
                          color: brandPrimaryColor,
                          fontSize: screenWidth * 0.15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: IntlPhoneField(
                        onChanged: (value) {
                          // Manually call validation when text changes
                          _formKey.currentState?.validate();
                        },
                        validator: (value) {
                          if (value == null || value.number.isEmpty) {
                            return "Please enter a phone number";
                          } else if (!RegExp(r'^[6-9]\d{9}$')
                              .hasMatch(value.number)) {
                            return "Enter a valid 10-digit phone number";
                          }
                          return null; // No error
                        },
                        controller: _phoneController,
                        initialCountryCode: 'IN',
                        cursorColor: brandPrimaryColor,
                        decoration: InputDecoration(
                          hintText: AppString.mobileNo,
                          hintStyle: TextStyle(
                              color: textPrimaryColor,
                              fontSize: screenWidth * 0.035),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide(color: brandPrimaryColor)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide:
                                BorderSide(color: brandPrimaryColor, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide:
                                BorderSide(color: brandPrimaryColor, width: 2),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: textPrimaryColor),
                        keyboardType: TextInputType.phone,
                        dropdownTextStyle: TextStyle(color: textPrimaryColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Text(
                        AppString.mobNoInstruction,
                        style: TextStyle(
                            color: textSecondaryColor,
                            fontSize: screenWidth * 0.032),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: AppString.term,
                        style: TextStyle(
                            color: textSecondaryColor,
                            fontSize: screenWidth * 0.03),
                        children: [
                          TextSpan(
                            text: AppString.condition,
                            style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: brandPrimaryColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Terms action
                              },
                          ),
                          TextSpan(
                              text: AppString.and,
                              style: TextStyle(fontSize: screenWidth * 0.03)),
                          TextSpan(
                            text: AppString.privacypolicy,
                            style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: brandPrimaryColor,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Privacy action
                              },
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.07),
                    SizedBox(
                        height: screenHeight * 0.065,
                        width: screenWidth * 0.4,
                        child: OnboardingButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _sendOtp();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyCodeScreen(
                                      phoneNumber: _phoneController.text.trim(),
                                    ),
                                  ),
                                );
                              }
                            },
                            buttonText: AppString.sendOtp)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
