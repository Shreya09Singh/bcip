import 'package:bciapplication/model/getSessionModel.dart';
import 'package:bciapplication/services/getsession_api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetsessionProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  String? _userId;
  String? _phone;

  String? get userId => _userId; // Getter to access userId
  String? get phone => _phone; // Getter to access userId

  Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    String? phoneNumber = prefs.getString('phone_number');

    return {
      'user_id': userId,
      'phone_number': phoneNumber,
    };
  }

  int get response1 => _user?.sessions[0].actualDuration ?? 0;
  int get response2 =>
      _user?.sessions[0].listenDuration ?? 1; // Avoid division by 0
  double get totalprogress =>
      (response2 > 0) ? (response1 / response2) * 100 : 0;

  final GetsessionApiServices _apiService = GetsessionApiServices();

  Future<void> fetchUser(String phone) async {
    Map<String, String?> userData = await getUserData();
    String? phoneno = userData['phone_number'];
    _isLoading = true;
    notifyListeners();

    UserModel? fetchedUser =
        await _apiService.fetchUserSessionData(phoneno.toString());

    if (fetchedUser != null) {
      _user = fetchedUser;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Map<String, dynamic> get sessionData {
  //   if (_user == null || _user!.sessions.isEmpty) {
  //     return {
  //       "greenval": 0.0,
  //       "sec": 0,
  //       "sessionName1": "No Session Available",
  //       "sessionName2": "No Session Available",
  //       "progresss1": 0,
  //       "progresss2": 0,
  //       "pro": 0.0,
  //     };
  //   }

  //   int sessionIndex = _user!.sessions.length - 1; // Last session

  //   double greenval =
  //       _user!.sessions[sessionIndex].selectedThreshold.toDouble();
  //   int sec = _user!.sessions[sessionIndex].actualDuration;
  //   int progresss1 = _user!.sessions[sessionIndex].actualDuration;
  //   int progresss2 = _user!.sessions[sessionIndex].listenDuration;

  //   double pro =
  //       (progresss2 > 0) ? (progresss1.toDouble() / progresss2.toDouble()) : 0;

  //   String sessionName1 = _user!.sessions[sessionIndex].sessionName;
  //   String sessionName2 = (sessionIndex > 0)
  //       ? _user!.sessions[sessionIndex - 1].sessionName
  //       : "No Session Available";

  //   return {
  //     "greenval": greenval,
  //     "sec": sec,
  //     "sessionName1": sessionName1,
  //     "sessionName2": sessionName2,
  //     "progresss1": progresss1,
  //     "progresss2": progresss2,
  //     "pro": pro,
  //   };
  // }
}
