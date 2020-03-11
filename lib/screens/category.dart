import 'package:cached_network_image/cached_network_image.dart';
import 'package:flute/router.dart';
import 'package:flute/widgets/homepage/artists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isMinimumScroll = false;

  ScrollController _scrollController = ScrollController();
  void _scrollListener() {
    if (_scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight)) {
      setState(() {
        isMinimumScroll = true;
      });
    } else {
      setState(() {
        isMinimumScroll = false;
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    List<Widget> _buildList(int count) {
      return List.generate(count, (index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(PlayerRoute);
          },
          title: Text(
            "Eminem",
            style: _theme.textTheme.title.merge(
              TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          subtitle: Text("Love the way you lie"),
          trailing: IconButton(
            icon: Icon(
              SimpleLineIcons.options_vertical,
              color: _theme.primaryColor,
              size: 18.0,
            ),
            onPressed: () {},
          ),
        );
      }).toList();
    }

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 270.0,
            title: AnimatedOpacity(
              opacity: isMinimumScroll ? 1.0 : 0.0,
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "https://cdn.pixabay.com/photo/2016/01/19/17/56/concert-1149979_960_720.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                isMinimumScroll
                    ? SizedBox()
                    : Positioned(
                        right: 30.0,
                        bottom: -30.0,
                        child: Container(
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
                            SimpleLineIcons.control_play,
                            color: _theme.primaryColor,
                          ),
                        ),
                      ),
                Positioned(
                  child: AnimatedOpacity(
                    opacity: isMinimumScroll ? 0.0 : 1.0,
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
                    "305 songs, 123 mins listen time",
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
              _buildList(50),
            ),
          )
        ],
      ),
    );
  }
}
