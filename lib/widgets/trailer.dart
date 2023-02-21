import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Trailer extends StatefulWidget {
  String vKey;

  Trailer({this.vKey});
  @override
  _TrailerState createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    var url = 'https://www.youtube.com/watch?v=${widget.vKey}';
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: true,
        ));
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) => Scaffold(
          backgroundColor: Colors.black,
          body: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              title: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
                  child: Text('Trailer')),
            ),
            body: Container(
              child: player,
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
