import 'package:audioplayers/audio_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flute/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerScreen extends StatefulWidget {
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  double _seekValue = 0.0;
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  bool _isPlaying = false;
  Duration _position;

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: blackColor),
        backgroundColor: _theme.scaffoldBackgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              SimpleLineIcons.heart,
              color: _theme.primaryColor,
              size: 20.0,
            ),
            onPressed: () {},
          )
        ],
        title: Text(
          "Now Playing",
          style: TextStyle(
            color: blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 300.0,
                  width: _size.width * 0.75,
                  decoration: BoxDecoration(
                    color: _theme.primaryColor,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "https://upload.wikimedia.org/wikipedia/en/e/e5/Marshmello_and_Bastille_Happier.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SliderTheme(
                  data: SliderThemeData(
                    trackShape: CustomTrackShape(),
                  ),
                  child: Slider(
                    activeColor: _theme.primaryColor,
                    value: _seekValue,
                    onChanged: (double value) {
                      print(value);
                      this.setState(() {
                        _seekValue = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: _size.width,
                child: Text(
                  "Happier",
                  textAlign: TextAlign.center,
                  style: _theme.textTheme.display1.merge(
                    TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              Container(
                width: _size.width,
                child: Text(
                  "Marshmello and Bastille",
                  textAlign: TextAlign.center,
                  style: _theme.textTheme.subtitle.merge(
                    TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
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
                        if (_isPlaying) {
                          await audioPlayer.pause();
                          this.setState(() {
                            _isPlaying = false;
                          });
                        } else {
                          await audioCache.play("audio.mp3");
                          this.setState(() {
                            _isPlaying = true;
                          });
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
                              blurRadius: 15.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? AntDesign.pause : AntDesign.caretright,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
