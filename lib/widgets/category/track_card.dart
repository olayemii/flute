import 'package:cached_network_image/cached_network_image.dart';
import 'package:flute/providers/music_provider.dart';
import 'package:flute/router.dart';
import 'package:flute/utils/get_real_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

List<Widget> buildList(List songs, BuildContext context) {
  final ThemeData _theme = Theme.of(context);

  return List.generate(songs.length, (index) {
    SongInfo _currentSong = songs[index];
    return ListTile(
      onTap: () {
        final MusicProvider provider =
            Provider.of<MusicProvider>(context, listen: false);
        provider.setMusic(
          _currentSong.artist,
          _currentSong.title,
          _currentSong.albumArtwork,
          null,
          true,
          Duration(
            milliseconds: int.parse(_currentSong.duration),
          ),
        );

        Navigator.of(context).pushNamed(
          PlayerRoute,
          arguments: {
            "title": _currentSong.title,
            "duration": _currentSong.duration,
            "path": _currentSong.filePath,
            "artist": _currentSong.artist,
            "albumArtPath": _currentSong.albumArtwork,
          },
        );
      },
      leading: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _currentSong.albumArtwork != null
                ? AssetImage(_currentSong.albumArtwork)
                : CachedNetworkImageProvider(
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
                  ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12.0),
          color: _theme.primaryColor,
        ),
      ),
      title: Text(
        _currentSong.artist,
        style: _theme.textTheme.title.merge(
          TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      subtitle: Text(_currentSong.title),
      trailing: IconButton(
        padding: EdgeInsets.all(0.0),
        icon: Icon(
          SimpleLineIcons.options_vertical,
          color: _theme.primaryColor,
          size: 18.0,
        ),
        onPressed: () {},
      ),
    );
  }).toList();
}
