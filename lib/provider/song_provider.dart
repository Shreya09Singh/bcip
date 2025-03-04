import 'package:bciapplication/model/recomendedModel.dart';
import 'package:bciapplication/services/api/api_song_services.dart';
import 'package:flutter/material.dart';

class SongProvider with ChangeNotifier {
  List<SongModel> _recommendedsonglist = [];
  List<SongModel> _searchsonglist = [];

  bool _isloading = false;
  String? _error;

  List<SongModel> get recommendedsong => _recommendedsonglist;
  List<SongModel> get searchsongslist => _searchsonglist;
  bool get isloading => _isloading;
  String? get error => _error;

  final ApiSongService _apiSongService = ApiSongService();
  Future<void> fetchRecomendedsongs() async {
    _isloading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _apiSongService.getRecommendedSongs();
      print("API Response: $response"); // Debugging
      _recommendedsonglist = response;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSearchsongs(String query) async {
    _isloading = true;
    _error = null;
    notifyListeners();
    try {
      final response = await _apiSongService.getsearchsong(query);
      print("API Response: $response"); // Debugging
      _searchsonglist = response;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isloading = false;
    }
  }

  void clearSearchResults() {
    _searchsonglist = [];
    notifyListeners();
  }
}
