import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  final String baseUrl = "https://bci-backend-qzzf.onrender.com/api";
  final String addUserUrl = "https://bci-backend-qzzf.onrender.com/users";

  Future<void> generateOtp(String phoneNumber) async {
    final Uri url = Uri.parse("$baseUrl/generate-otp");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phoneNumber": phoneNumber}),
      );

      if (response.statusCode == 200) {
        print("OTP sent successfully: ${response.body}");
      } else {
        print("Failed to generate OTP: ${response.body}");
      }
    } catch (e) {
      print("Error generating OTP: $e");
    }
  }

  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    final Uri url = Uri.parse("$baseUrl/verify-otp");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phoneNumber": phoneNumber,
          "otp": otp,
        }),
      );

      if (response.statusCode == 200) {
        print("OTP verification successful: ${response.body}");
        return true;
      } else {
        print("OTP verification failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      return false;
    }
  }

  Future<bool> addUser(
      {required String name,
      required int age,
      required String gender,
      required String phoneNumber,
      String email = "default@example.com", // Default email
      required String dob}) async {
    final Uri url = Uri.parse("$addUserUrl/addUser");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": "",
          "name": name,
          "age": age,
          "gender": gender,
          "brainAge": age + 2, // Example logic
          "records": [],
          "isPremiumUser": false,
          "premiumExpireDate": null,
          "score": 1400,
          "likes": [],
          "mostOpened": [],
          "eachSessionTime": [],
          "phoneNumber": phoneNumber,
          "email": email, // Add email, even if backend ignores it
          "dob": dob,
        }),
      );

      if (response.statusCode == 200) {
        print("User added successfully: ${response.body}");
        return true;
      } else {
        print("Failed to add user: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error adding user: $e");
      return false;
    }
  }
}
