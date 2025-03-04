class SongModel {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String filePath;
  final String imageUrl;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.filePath,
    this.imageUrl =
        "https://i.ytimg.com/vi/jv_uolrknjA/maxresdefault.jpg", // Default Image URL
  });

  // Factory constructor to create a Song object from JSON
  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      filePath: json['filePath'],
      imageUrl: json['imageUrl'] ??
          "https://i.ytimg.com/vi/jv_uolrknjA/maxresdefault.jpg", // Use default if null
    );
  }
}
