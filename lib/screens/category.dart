import 'package:cached_network_image/cached_network_image.dart';
import 'package:flute/router.dart';
import 'package:flute/utils/play_time_total.dart';
import 'package:flute/widgets/category/track_card.dart';
import 'package:flute/widgets/homepage/artists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isMinimumScroll = false;
  bool _isCollapsed = false;
  FlutterAudioQuery _audioQuery;
  List<SongInfo> _songs = [];
  ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    /**
     * If checks to reduce unnecessary rerenders... Only change state if state is not what it should be
     */
    if (_scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight)) {
      if (!_isMinimumScroll) {
        setState(() {
          _isMinimumScroll = true;
        });
      }
    } else {
      if (_isMinimumScroll) {
        setState(() {
          _isMinimumScroll = false;
        });
      }
    }
    // Keep track if sliver app bar is collapsed
    if (_scrollController.hasClients && _scrollController.offset >= 220.0) {
      if (!_isCollapsed) {
        setState(() {
          _isCollapsed = true;
        });
      }
    } else {
      if (_isCollapsed) {
        setState(() {
          _isCollapsed = false;
        });
      }
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    checkTracks();
    super.initState();
  }

  void checkTracks() async {
    _audioQuery = FlutterAudioQuery();
    _songs = await _audioQuery.getSongs();
    setState(() {
      _songs = _songs;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 270.0,
            title: AnimatedOpacity(
              opacity: _isMinimumScroll ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Text("Rock"),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(AntDesign.search1),
                onPressed: () {},
              )
            ],
            flexibleSpace: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Hero(
                  tag: "rock",
                  child: Container(
                    decoration: _isCollapsed
                        ? null
                        : BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                "https://cdn.pixabay.com/photo/2016/01/19/17/56/concert-1149979_960_720.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                _isMinimumScroll
                    ? SizedBox()
                    : Positioned(
                        right: 30.0,
                        bottom: -30.0,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
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
                            SimpleLineIcons.control_play,
                            color: _theme.primaryColor,
                            size: 24.0,
                          ),
                        ),
                      ),
                Positioned(
                  child: AnimatedOpacity(
                    opacity: _isMinimumScroll ? 0.0 : 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Rock",
                        style: _theme.textTheme.display1.merge(
                          TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    duration: Duration(milliseconds: 100),
                  ),
                  bottom: 0.0,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  HomepageArtists(),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Songs",
                    style: _theme.textTheme.title,
                  ),
                  Text(
                    "${_songs.length} songs, ${totalPlayTime(_songs)} listen time",
                    style: _theme.textTheme.subtitle.merge(TextStyle(
                      color: Colors.grey,
                    )),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              buildList(_songs, context),
            ),
          )
        ],
      ),
    );
  }
}
