import 'package:flute/widgets/artistcard.dart';
import 'package:flute/widgets/homepage/artists.dart';
import 'package:flute/widgets/homepage/genres.dart';
import 'package:flute/widgets/homepage/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Homepage extends StatelessWidget {
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
