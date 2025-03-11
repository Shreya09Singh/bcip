import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bciapplication/model/getSessionModel.dart';

class GetsessionApiServices {
  final String baseUrl = "https://bci-backend-qzzf.onrender.com";

  Future<UserModel?> fetchUserSessionData(String phoneNumber) async {
    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      print("Error: Invalid phone number");
      return null;
    }

    final url = Uri.parse("$baseUrl/users/getUserByNumber/$phoneNumber");
    print("Fetching data from: $url");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } on http.ClientException catch (e) {
      print("ClientException: $e");
      return null;
    } catch (e) {
      print("Unexpected Error: $e");
      return null;
    }
  }
}
