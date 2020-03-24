import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicProvider extends ChangeNotifier {
  static String _artist;
  static String _track;
  static String _albumArt;
  static String _path;
  static Duration _currentDuration;
  static Duration _totalDuration;
  static bool _isPlaying;
  static AudioPlayer _playerInstance;

  void setMusic([
    artist,
    track,
    albumArt,
    currentDuration,
    isPlaying,
    totalDuration,
    path,
  ]) {
    _artist = artist;
    _track = track;
    _albumArt = albumArt;
    _currentDuration = currentDuration == null ? Duration() : currentDuration;
    _isPlaying = isPlaying == null ? false : isPlaying;
    _totalDuration = totalDuration == null ? Duration() : totalDuration;
    _path = path;
    notifyListeners();
  }

  set currentDuration(Duration d) {
    _currentDuration = d;
    notifyListeners();
  }

  set audioInstance(AudioPlayer player) {
    _playerInstance = player;
    notifyListeners();
  }

  get path {
    return _path;
  }

  get audioInstance {
    return _playerInstance;
  }

  get currentDuration {
    return _currentDuration != null ? _currentDuration.inMilliseconds : 0;
  }

  set totalDuration(Duration d) {
    _totalDuration = d;
    notifyListeners();
  }

  set isPlaying(bool val) {
    _isPlaying = val;
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
