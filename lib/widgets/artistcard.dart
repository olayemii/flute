import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistCard extends StatelessWidget {
  final String name;
  final String image;
  final String title;
  final int rating;
  ArtistCard({this.name, this.image, this.rating, this.title});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      width: 125.0,
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    image,
                  ),
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 3.0,
            ),
            child: title != null
                ? Text(
                    title,
                    style: _theme.textTheme.subhead.merge(
                      TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 3.0,
            ),
            child: Text(
              name,
              style: _theme.textTheme.caption.merge(
                TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Container(
              child: Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: _theme.primaryColor,
                size: 16.0,
              ),
            ).toList(),
          )),
        ],
      ),
    );
  }
}
