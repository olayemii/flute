import 'package:flutter/material.dart';

class MusicProvider extends ChangeNotifier {
  String _artist;
  String _track;
  String _albumArt;
  Duration _currentDuration;
  bool _isPlaying;

  MusicProvider(artist, track, albumArt, currentDuration, isPlaying) {
    this._artist = artist;
    this._track = track;
    this._albumArt = albumArt;
    this._currentDuration =
        currentDuration == null ? Duration() : currentDuration;
    this._isPlaying = isPlaying == null ? false : isPlaying;

    notifyListeners();
  }

  set duration(Duration d) {
    this._currentDuration = d;
    notifyListeners();
  }

  get duration {
    return _currentDuration;
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
