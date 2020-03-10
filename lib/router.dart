import 'package:flute/screens/homepage.dart';
import 'package:flutter/material.dart';

const HomepageRoute = "/homepage";

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomepageRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Homepage());
    default:
      return MaterialPageRoute(builder: (BuildContext context) => Homepage());
  }
}
