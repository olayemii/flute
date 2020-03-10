import 'package:flutter/material.dart';

import 'package:flute/styles/colors.dart';

/*
 * Still a lot to check when there is a working emulator
 */

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  primaryColorLight: lightOrange,
  accentColor: primaryColor,
  disabledColor: lightOrange,
  backgroundColor: lightOrange,
  fontFamily: "Poppins",
  textTheme: TextTheme(
    body1: TextStyle(),
    display1: TextStyle(),
  ).apply(
    displayColor: Color(0xff333333),
    bodyColor: Color(0xff333333),
  ),
);
