// import 'dart:convert';
// import 'package:bciapplication/model/recomendedModel.dart';
// import 'package:http/http.dart' as http;

// class ApiSongService {
//   static const String baseUrl = "https://bci-backend-qzzf.onrender.com/songs";

//   // Fetch recommended songs
//   // Future<List<SongModel>> getRecommendedSongs() async {
//   //   try {
//   //     final response = await http.get(Uri.parse('$baseUrl/recomended-song'));

//   //     print('Response Status Code: ${response.statusCode}');
//   //     print('Response Body: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       List<dynamic> jsonData = json.decode(response.body);
//   //       print('Decoded JSON Data: $jsonData'); // ✅ Check parsed JSON
//   //       return jsonData.map((json) => SongModel.fromJson(json)).toList();
//   //     } else {
//   //       print('Failed to load recommended songs: ${response.reasonPhrase}');
//   //       throw Exception('Failed to load recommended songs');
//   //     }
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     throw Exception('Error: $e');
//   //   }
//   // }

// //**Search Songs by Title, Artist, or Album**
//   Future<List<SongModel>> getsearchsong(String query) async {
//     try {
//       final response = await http.get(Uri.parse("$baseUrl/search?name=$query"));

//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => SongModel.fromJson(json)).toList();
//       } else {
//         throw Exception("Failed to search songs");
//       }
//     } catch (e) {
//       throw Exception("Error searching songs: $e");
//     }
//   }
// }
