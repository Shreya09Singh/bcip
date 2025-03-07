import 'package:bciapplication/model/getSessionModel.dart';
import 'package:bciapplication/services/getsession_api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetsessionProvider with ChangeNotifier {
  Getsessionmodel? _user;
  bool _isLoading = false;

  Getsessionmodel? get user => _user;
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

    Getsessionmodel? fetchedUser =
        await _apiService.fetchUserSessionData(phoneno.toString());

    if (fetchedUser != null) {
      _user = fetchedUser;
    }

    _isLoading = false;
    notifyListeners();
  }
}
