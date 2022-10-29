import 'package:flutter/material.dart';
import 'package:youtube_music/src/models/song.dart';

class SongDetailsProvider with ChangeNotifier {
  Song? _song;

  Song? get song => _song;

  void updateSongDetails(Song? song) {
    _song = song;
    notifyListeners();
  }

  int _songDuration = 0;

  int get songDuration => _songDuration;

  void updateSongDuration(int songDuration) {
    _songDuration = songDuration;
    notifyListeners();
  }
}
