import 'package:flute/screens/category.dart';
import 'package:flute/screens/homepage.dart';
import 'package:flute/screens/player_screen.dart';
import 'package:flutter/material.dart';

const HomepageRoute = "/homepage";
const CategoryRoute = "/category";
const PlayerRoute = "/player";

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomepageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Homepage());
    case CategoryRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>
              Category(arguments: settings.arguments));
    case PlayerRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>
              PlayerScreen(arguments: settings.arguments));
    default:
      return MaterialPageRoute(builder: (BuildContext context) => Homepage());
  }
}
