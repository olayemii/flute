import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  final String genre;
  final String background;

  GenreCard({this.genre, this.background})
      : assert(genre != null),
        assert(background != null);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          height: 170.0,
          width: 125.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                background,
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              genre.toUpperCase(),
              style: _theme.textTheme.display1.merge(
                TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
