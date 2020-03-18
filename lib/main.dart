import 'package:flute/providers/music_provider.dart';
import 'package:flute/router.dart';
import 'package:flute/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => MusicProvider(),
        child: MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          initialRoute: HomepageRoute,
        ),
      ),
    );
