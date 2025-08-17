// models/song_model.dart
class Song {
  final String title;
  final String artist;
  final String audioPath;
  final String imagePath;
  final Duration? duration;

  Song({
    required this.title,
    required this.artist,
    required this.audioPath,
    required this.imagePath,
    this.duration,
  });
}
