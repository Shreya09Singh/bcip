import 'package:bciapplication/model/recomendedModel.dart';
import 'package:bciapplication/services/api/api_song_services.dart';
import 'package:flutter/material.dart';

class Recomendedong extends StatefulWidget {
  const Recomendedong({super.key});

  @override
  State<Recomendedong> createState() => _RecomendedongState();
}

class _RecomendedongState extends State<Recomendedong> {
  ApiSongService _apisongservice = ApiSongService();
  Future<List<SongModel>>? _recomendedsongs;

  void fetchrecommendedSongs() {
    setState(() {
      _recomendedsongs = _apisongservice.getRecommendedSongs();
    });

    _recomendedsongs!.then((songs) {
      print('Fetched songs: ${songs.length}'); // ✅ Debugging Log
    }).catchError((error) {
      print('Error fetching songs: $error'); // ✅ Error Log
    });
  }

  @override
  void initState() {
    super.initState();
    fetchrecommendedSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            // ✅ Ensures ListView takes available space
            child: FutureBuilder<List<SongModel>>(
              future: _recomendedsongs,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white)));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No recommended songs found',
                        style: TextStyle(color: Colors.white)),
                  );
                } else {
                  List<SongModel> songs = snapshot.data!;
                  return ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            songs[index].imageUrl ??
                                'https://via.placeholder.com/50', // ✅ Fallback Image
                          ),
                        ),
                        title: Text(songs[index].title,
                            style: TextStyle(color: Colors.white)),
                        subtitle: Text(songs[index].artist,
                            style: TextStyle(color: Colors.white54)),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
