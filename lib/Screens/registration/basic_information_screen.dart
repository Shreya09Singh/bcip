import 'package:bciapplication/Screens/meditaion/meditaion_screen.dart';

import 'package:bciapplication/Screens/splash/Welcome_screen.dart';
import 'package:bciapplication/services/api/API_services.dart';

import 'package:bciapplication/utils/constants.dart';
import 'package:bciapplication/utils/string.dart';

import 'package:bciapplication/widget/onboarding_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasicInformationScreen extends StatefulWidget {
  BasicInformationScreen({Key? key}) : super(key: key);

  @override
  _BasicInformationScreenState createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final APIService _apiService = APIService();
  String? selectedGender;

  DateTime? selectedDate;

  void submitUser() async {
    String name = titlecontroller.text.trim();

    String email = emailcontroller.text.trim().isEmpty
        ? "default@example.com"
        : emailcontroller.text.trim(); // Default email

    if (name.isEmpty || selectedGender == null || selectedDate == null) {
      showSnackBar("Please fill all fields!");
      return;
    }

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate!); // Format Date

    bool isSuccess = await _apiService.addUser(
      name: name,
      age: 23,
      gender: selectedGender!,
      phoneNumber: '7317093723',
      email: email, // Send email (backend ignores it)
      dob: formattedDate,
    );

    if (!mounted) return;

    if (isSuccess) {
      showSnackBar("User added successfully!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    } else {
      showSnackBar("Failed to add user. Try again.");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: backgroundWhiteColor),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MeditaionScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    AppString.basicinformation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: brandPrimaryColor,
                      fontSize: 43, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                buildTextField(
                  txtcontroller: titlecontroller,
                  hintText: AppString.fullname,
                  icon: Icons.person,
                ),
                SizedBox(height: screenHeight * 0.035),
                SizedBox(
                  height: screenHeight * 0.08,
                  child: buildTextField(
                    txtcontroller: emailcontroller,
                    hintText: AppString.emailaddress,
                    icon: Icons.email,
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: brandPrimaryColor,
                              onPrimary: textPrimaryColor,
                              surface: backgroundBlackColor,
                              onSurface: textPrimaryColor,
                            ),
                            dialogBackgroundColor: Colors.black,
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.022,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: brandPrimaryColor),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: brandPrimaryColor),
                        const SizedBox(width: 10),
                        Text(
                          selectedDate == null
                              ? 'DD / MM / YYYY'
                              : DateFormat('dd / MM / yyyy')
                                  .format(selectedDate!),
                          style: const TextStyle(color: textPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  decoration: BoxDecoration(
                    border: Border.all(color: brandPrimaryColor),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: SizedBox(
                    height: screenHeight * 0.076,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text(
                        AppString.gender,
                        style: TextStyle(color: textPrimaryColor),
                      ),
                      value: selectedGender,
                      dropdownColor: Colors.black,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: textPrimaryColor),
                      items: AppString.genderOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: textPrimaryColor),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),
                Center(
                  child: SizedBox(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.5,
                      child: OnboardingButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              submitUser();
                            }
                          },
                          buttonText: AppString.continuee)),
                ),
                SizedBox(height: screenHeight * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppString.needhelp,
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        AppString.helpcenter,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildTextField(
    {required String hintText,
    IconData? icon,
    bool isicon = true,
    required TextEditingController txtcontroller}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a phone number';
      }
      return null;
    },
    controller: txtcontroller,
    style: const TextStyle(color: textPrimaryColor),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: textSecondaryColor),

      prefixIcon: isicon
          ? Icon(Icons.task, color: Colors.blue)
          : null, // No dead code warning,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: brandPrimaryColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: brandPrimaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    ),
  );
}
