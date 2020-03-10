import 'package:flutter/material.dart';

class HomepageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "Library",
            style: _theme.textTheme.display1.merge(
              TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: _theme.primaryColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
