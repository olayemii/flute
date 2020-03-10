import 'package:flute/router.dart';
import 'package:flute/styles/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
      ),
    );
