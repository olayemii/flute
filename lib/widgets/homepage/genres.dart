import 'package:flute/router.dart';
import 'package:flute/widgets/homepage/genre_card.dart';
import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Genres",
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
          height: 170.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(CategoryRoute);
                },
                child: Hero(
                  tag: "rock",
                  child: GenreCard(
                    genre: "rock",
                    background:
                        "https://cdn.pixabay.com/photo/2016/01/19/17/56/concert-1149979_960_720.jpg",
                  ),
                ),
              ),
              GenreCard(
                genre: "pop",
                background:
                    "https://cdn.pixabay.com/photo/2016/11/19/11/11/artist-1838653_960_720.jpg",
              ),
              GenreCard(
                genre: "dance",
                background:
                    "https://cdn.pixabay.com/photo/2013/11/03/08/05/cheers-204742_960_720.jpg",
              ),
              GenreCard(
                genre: "jazz",
                background:
                    "https://cdn.pixabay.com/photo/2018/03/06/06/58/performance-3202707_960_720.jpg",
              ),
              GenreCard(
                genre: "hip hop",
                background:
                    "https://cdn.pixabay.com/photo/2016/12/17/07/32/hip-hop-1912921_960_720.jpg",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
