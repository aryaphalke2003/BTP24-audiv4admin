import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:visibility_detector/visibility_detector.dart';

// import 'package: flutter/cupertino.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  const VideoItems(
      {Key? key,
      required this.videoPlayerController,
      required this.looping,
      required this.autoplay})
      : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late ChewieController _chewieController;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  // https://drive.google.com/uc?export=download&id=15EWIaMD0NV_EfohiT-PNxoCcrWpM9xTT
  // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3"
  final String path ="https://drive.google.com/file/d/1YxlKygqbZ0AoL-WJBzqWm23b9Uqokift/view?usp=sharing";
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  double speed = 1;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 5 / 8,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: VisibilityDetector(
        key: Key("unique key"),
        onVisibilityChanged: (VisibilityInfo info) {
          debugPrint("${info.visibleFraction} of my widget is visible");
          if (info.visibleFraction == 0) {
            widget.videoPlayerController.pause();
          } else {
            widget.videoPlayerController.play();
          }
        },
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }
}
