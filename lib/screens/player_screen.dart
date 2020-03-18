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
  PlayerScreen({this.arguments}) : assert(arguments != null);
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  double _seekValue = 0.0;
  AudioPlayer audioPlayer;
  String _seekStr = "";
  MusicProvider provider;

  @override
  void initState() {
    print(widget.arguments);
    initPlayer();
    setState(() {
      _seekStr = formatSeekValue(_seekValue);
    });
    super.initState();
  }

  String formatSeekValue(double val) {
    return getRealDuration(val.toInt().toString());
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
    // audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  void didChangeDependencies() {
    MusicProvider np = Provider.of<MusicProvider>(context);
    audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      updateSeekValue((np.currentDuration / np.totalDuration).toDouble, np);
    });
    super.didChangeDependencies();
  }

  void updateSeekValue(double val, data) {
    data.currentDuration = Duration(
      milliseconds: (val * data.totalDuration).toInt(),
    );
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
          child: Consumer<MusicProvider>(
            builder: (BuildContext context, data, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 300.0,
                      width: _size.width * 0.75,
                      decoration: BoxDecoration(
                        color: _theme.primaryColor,
                        image: DecorationImage(
                          image: AssetImage(data.albumArt),
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
                          width: 30.0,
                          constraints: BoxConstraints(
                            maxWidth: 40.0,
                          ),
                          child: Text(
                            "${formatSeekValue(data.currentDuration.toDouble())}",
                            style: TextStyle(fontSize: 11.0),
                          ),
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
                                print(value);
                                updateSeekValue(value, data);
                                // audioPlayer.seek(
                                //   Duration(
                                //     milliseconds:
                                //         (value * provider.currentDuration)
                                //             .toInt(),
                                //   ),
                                // );
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
