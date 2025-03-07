import 'dart:convert';
import 'package:bciapplication/model/getSessionModel.dart';
import 'package:http/http.dart' as http;

class GetsessionApiServices {
  final String baseUrl =
      "https://bci-backend-qzzf.onrender.com"; // Replace with actual API

  Future<Getsessionmodel?> fetchUserSessionData(String phonenumber) async {
    print("Phone Number Received: $phonenumber"); // Debugging

    if (phonenumber.isEmpty || phonenumber.length < 10) {
      print("Error: Invalid phone number");
      return null;
    }

    final url = Uri.parse(
        "https://bci-backend-qzzf.onrender.com/users/getUserByNumber/$phonenumber");
    print("Fetching data from: $url");

    try {
      final response = await http.get(url);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return Getsessionmodel.fromJson(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
