import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../providers/music_provider.dart';

class PlayControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final MusicProvider mp = Provider.of<MusicProvider>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              AntDesign.retweet,
              color: _theme.primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              AntDesign.stepbackward,
              color: _theme.primaryColor,
            ),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () async {
              if (mp.isPlaying) {
                await mp.audioInstance.pause();
                mp.isPlaying = false;
              } else {
                print("The value is ${mp.path}");
                await mp.audioInstance.play(mp.path);
                mp.isPlaying = true;
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                mp.isPlaying ? AntDesign.pause : AntDesign.caretright,
                color: _theme.primaryColor,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              AntDesign.stepforward,
              color: _theme.primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              AntDesign.swap,
              color: _theme.primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
