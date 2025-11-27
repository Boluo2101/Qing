// UI
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Tools
import 'package:go_router/go_router.dart';

class VideoPage extends StatefulWidget {
  final String videoUrl;

  const VideoPage({super.key, required this.videoUrl});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.setPlaybackSpeed(1.0);
          // 静音
          _controller.setVolume(0.0);
          // 循环
          _controller.setLooping(true);
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : Container(decoration: BoxDecoration(color: Colors.orange));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
