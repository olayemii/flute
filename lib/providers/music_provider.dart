import 'package:flutter/material.dart';

class MusicProvider extends ChangeNotifier {
  static String _artist;
  static String _track;
  static String _albumArt;
  static Duration _currentDuration;
  static Duration _totalDuration;
  static bool _isPlaying;

  void setMusic(
      [artist, track, albumArt, currentDuration, isPlaying, totalDuration]) {
    _artist = artist;
    _track = track;
    _albumArt = albumArt;
    _currentDuration = currentDuration == null ? Duration() : currentDuration;
    _isPlaying = isPlaying == null ? false : isPlaying;
    _totalDuration = totalDuration == null ? Duration() : totalDuration;
    notifyListeners();
  }

  set currentDuration(Duration d) {
    _currentDuration = d;
    notifyListeners();
  }

  get currentDuration {
    return _currentDuration != null ? _currentDuration.inMilliseconds : 0;
  }

  set totalDuration(Duration d) {
    _totalDuration = d;
    notifyListeners();
  }

  get totalDuration {
    return _totalDuration != null ? _totalDuration.inMilliseconds : 0;
  }

  get artist {
    return _artist;
  }

  get track {
    return _track;
  }

  get isPlaying {
    return _isPlaying;
  }

  get albumArt {
    return _albumArt;
  }
}
