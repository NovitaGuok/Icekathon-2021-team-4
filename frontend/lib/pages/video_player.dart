import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;
  final String title;

  VideoPlayerPage({required this.url, required this.title});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState(url, title);
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  final String url;
  final String title;

  _VideoPlayerPageState(this.url, this.title);

  @override
  void initState() {
    String id = YoutubePlayer.convertUrlToId(url)!;
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          builder: (context, player) {
            return player;
          },
        ),
      ),
    );
  }
}