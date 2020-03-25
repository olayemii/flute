import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:flute/providers/music_provider.dart';
import 'package:flute/styles/colors.dart';
import 'package:flute/widgets/playerscreen/play_controls.dart';
import 'package:flutter/material.dart';
import 'package:flute/utils/get_real_time.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  final Map arguments;
  PlayerScreen({this.arguments});
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  AudioPlayer audioPlayer;
  MusicProvider provider;

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  String formatSeekValue(double val) {
    return getRealDuration(val.toInt().toString());
  }

  void initPlayer() {
    MusicProvider np = Provider.of<MusicProvider>(context, listen: false);
    if (np.audioInstance != null && widget.arguments["path"] == np.path) {
      audioPlayer = np.audioInstance;
      np.audioInstance.play(np.path);
    } else {
      audioPlayer = AudioPlayer(playerId: 'flute_player');
    }
  }

  @override
  void didChangeDependencies() {
    MusicProvider np = Provider.of<MusicProvider>(context);
    Future.delayed(Duration(seconds: 0)).then((_) {
      if (np.audioInstance == null) {
        np.audioInstance = audioPlayer;
        np.audioInstance.onAudioPositionChanged.listen((Duration duration) {
          print("Still listening");
          updateSeekValue(
              (duration.inMilliseconds / np.totalDuration).toDouble(), np);
        });
        np.audioInstance.onPlayerCompletion.listen((ev) {
          np.audioInstance.seek(Duration(seconds: 0));
          np.isPlaying = false;
        });
        np.audioInstance.play(np.path);
      }

      super.didChangeDependencies();
    });
  }

  void updateSeekValue(double val, data) {
    print(val);
    data.currentDuration = Duration(
      milliseconds: (val * data.totalDuration).toInt(),
    );
  }

  @override
  void dispose() {
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
          constraints:
              BoxConstraints(minHeight: _size.height - (kToolbarHeight + 56)),
          padding: EdgeInsets.all(24.0),
          child: Consumer<MusicProvider>(
            builder: (BuildContext context, data, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: _size.height * 0.5,
                      width: _size.width * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: data.albumArt == null
                              ? AssetImage("assets/images/headphonelg.png")
                              : FileImage(File(data.albumArt)),
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
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 35.0,
                          constraints: BoxConstraints(
                            maxWidth: 45.0,
                          ),
                          child: Text(
                            "${formatSeekValue(data.currentDuration.toDouble())}",
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                            ),
                            child: Slider(
                              activeColor: _theme.primaryColor,
                              inactiveColor: lightOrange,
                              value: (data.currentDuration / data.totalDuration)
                                  .toDouble(),
                              onChanged: (double value) {
                                print("Changed");
                                audioPlayer.seek(
                                  Duration(
                                    milliseconds:
                                        (value * data.totalDuration).toInt(),
                                  ),
                                );
                                // updateSeekValue(value, data);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 7.0),
                        Container(
                          width: 30.0,
                          constraints: BoxConstraints(
                            maxWidth: 40.0,
                          ),
                          child: Text(
                            formatSeekValue(data.totalDuration.toDouble()),
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: _size.width,
                    child: Text(
                      "${data.track}",
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
                      "${data.artist}",
                      textAlign: TextAlign.center,
                      style: _theme.textTheme.subtitle.merge(
                        TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  PlayControl(),
                ],
              );
            },
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
