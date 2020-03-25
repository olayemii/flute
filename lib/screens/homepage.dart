import 'dart:convert';

import 'package:flute/widgets/artistcard.dart';
import 'package:flute/widgets/homepage/artists.dart';
import 'package:flute/widgets/homepage/genres.dart';
import 'package:flute/widgets/homepage/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FlutterAudioQuery _audioQuery;
  List<SongInfo> _songs = [];
  @override
  void initState() {
    /**
     * Fetch all songs on device, cache the json, [use map for albums], artists
     * Fetch my genres too and cache
     * Invalidate cache my checking music length with cached music length
     */
    fetchTracks();
    super.initState();
  }

  void fetchTracks() async {
    // SharedPreferences sp = await SharedPreferences.getInstance()

    _audioQuery = FlutterAudioQuery();
    _songs = await _audioQuery.getSongs();

    // sp.setStringList('song_list', songListMap(_songs))

    songListMap(_songs);
  }

  dynamic songListMap(List<SongInfo> songs) {
    Map artists = {};
    Map albums = {};

    return songs.map((song) {
      if (artists[song.artist] == null) {
        artists[song.artist] = [];
      }

      if (albums[song.album] == null) {
        albums[song.album] = [];
      }

      artists[song.artist].add(song);
      albums[song.album].add(song);

      print(artists);
      return {
        "song_list": song.toMap,
        "artists": artists,
        "albums": albums,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14.0,
        elevation: 40.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.clock),
            title: Text('Recent'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.play),
            title: Text('Play'),
          ),
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.playlist),
            title: Text('Playlist'),
          ),
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HomepageHeader(),
                SizedBox(
                  height: 40.0,
                ),
                HomepageArtists(),
                SizedBox(
                  height: 30.0,
                ),
                Genres(),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Albums",
                        style: _theme.textTheme.title,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "View More >",
                        style: _theme.textTheme.subtitle.merge(
                          TextStyle(
                            color: _theme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 220.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ArtistCard(
                        title: "Lauv",
                        name: "I like me better",
                        rating: 4,
                        image:
                            "https://assets.audiomack.com/marielle-caroline-borja/marielle-caroline-borja-275-275-1503841990.jpg",
                      ),
                      ArtistCard(
                        title: "Marshmello",
                        name: "Happier",
                        rating: 5,
                        image:
                            "https://upload.wikimedia.org/wikipedia/en/e/e5/Marshmello_and_Bastille_Happier.png",
                      ),
                      ArtistCard(
                        title: "Jhene Aiko",
                        name: "Chilombo",
                        rating: 3,
                        image:
                            "https://assets.audiomack.com/jhene-aiko/1b037f759694e0d5a7972faf5e7d356142b0335b47ec02dc27a5f378a005c8df.jpeg?width=260&height=260&max=true",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
