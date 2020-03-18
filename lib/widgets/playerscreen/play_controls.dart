import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PlayControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Rebuilding...");
    final ThemeData _theme = Theme.of(context);
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
              // if (_isPlaying) {
              //   await audioPlayer.pause();
              //   this.setState(() {
              //     _isPlaying = false;
              //   });
              // } else {
              //   await audioPlayer.play(widget.arguments["path"]);
              //   this.setState(() {
              //     _isPlaying = true;
              //   });
              // }
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
                true ? AntDesign.pause : AntDesign.caretright,
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
