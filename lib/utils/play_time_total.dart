import 'package:flutter_audio_query/flutter_audio_query.dart';

String totalPlayTime(List<SongInfo> songs) {
  int totalMs = 0;
  List<String> playTimeValues = [];

  songs.forEach((song) {
    totalMs += int.parse(song.duration);
  });

  List duration =
      Duration(milliseconds: totalMs).toString().split(RegExp('[\.\:]'));

  if (!(int.parse(duration[0]) == 0)) {
    playTimeValues.add("${duration[0]} hours");
  }

  if (!(int.parse(duration[1]) == 0)) {
    playTimeValues.add("${duration[1]} minutes");
  }

  if (!(int.parse(duration[2]) == 0)) {
    playTimeValues.add("${duration[2]} seconds");
  }

  return playTimeValues.join(" , ");
}
