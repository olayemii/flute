import 'package:flute/models/genre_info.dart';
import 'package:flute/router.dart';
import 'package:flute/widgets/homepage/genre_card.dart';
import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  final List<GenreRender> _genres = [
    GenreRender(name: "rock", image: "assets/images/rock.jpg"),
    GenreRender(name: "pop", image: "assets/images/pop.jpg"),
    GenreRender(name: "dance", image: "assets/images/dance.jpg"),
    GenreRender(name: "hip-hop", image: "assets/images/hiphop.jpg"),
    GenreRender(name: "jazz", image: "assets/images/jazz.jpg"),
  ];
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
            children: _genres.map(
              (genre) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(CategoryRoute, arguments: {"genre": genre});
                  },
                  child: Hero(
                    tag: genre.name,
                    child: GenreCard(
                      genre: genre.name,
                      background: genre.image,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
