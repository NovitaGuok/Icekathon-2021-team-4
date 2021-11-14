import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String url;
  final String title;

  VideoPlayerPage({required this.url, required this.title});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState(url, title);
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  final String url;
  final String title;

  _VideoPlayerPageState(this.url, this.title);

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoPlay: false,
    );
    _betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.network, url);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}