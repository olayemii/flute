import 'package:flute/widgets/artistcard.dart';
import 'package:flutter/material.dart';

class HomepageArtists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                "Artists",
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
          height: 190.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ArtistCard(
                name: "Eminem",
                rating: 4,
                image:
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
              ),
              ArtistCard(
                name: "Eminem",
                rating: 4,
                image:
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
              ),
              ArtistCard(
                name: "Eminem",
                rating: 4,
                image:
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
              ),
              ArtistCard(
                name: "Eminem",
                rating: 4,
                image:
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
              ),
              ArtistCard(
                name: "Eminem",
                rating: 4,
                image:
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
              ),
              ArtistCard(
                name: "Eminem",
                rating: 4,
                image:
                    "https://www.rollingstone.com/wp-content/uploads/2018/06/eminem-track-by-track-revival-new-57b63db3-3bb9-4b7e-b3a4-7f0e48714a0e.jpg",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
