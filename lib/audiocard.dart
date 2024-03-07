import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'videoItems.dart';
import 'package:url_launcher/url_launcher.dart';

class AudioCard extends StatefulWidget {
  final snap;

  const AudioCard({required this.snap});

  @override
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  int postLen = 0;
  int index = 0;
  List<Duration> _sections = [];
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    try {
      _controller = VideoPlayerController.network(
        widget.snap['AudioFile'].toString(),
      )..initialize().then((_) {
          setState(() {
            postLen = _controller.value.duration.inSeconds;
            for (int i = 0; i < postLen; i += 600) {
              _sections.add(Duration(seconds: i));
            }
          });
        });
    } catch (e) {
      print("Error initializing video player: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchPDF(String pdfLink) async {
    // Check if the PDF link is not null
    if (pdfLink != null) {
      // Use the url_launcher package to open the PDF link
      await launch(pdfLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: _controller.value.isInitialized ? 200 : 50,
            child: _controller.value.isInitialized
                ? VideoItems(
                    videoPlayerController: _controller,
                    looping: true,
                    autoplay: false,
                  )
                : widget.snap['AudioFile'] != null
                    ? CircularProgressIndicator()
                    : Text('No Audiobook available'),
          ),
        ),

        SizedBox(height: 10),
        // Conditionally render playback controls and buffering indicator
        widget.snap['AudioFile'] != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        index = (index - 1 + _sections.length) % _sections.length;

                        _controller.seekTo(_sections[index]);
                      });
                    },
                    child: Text('Previous Section'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        index = (index + 1) % _sections.length;

                        _controller.seekTo(_sections[index]);
                      });
                    },
                    child: Text('Next Section'),
                  ),
                ],
              )
            : SizedBox.shrink(), // Empty widget if AudioFile is null
        SizedBox(height: 20),
        widget.snap['PDF'] != null
            ? ElevatedButton(
                onPressed: () {
                  // Handle PDF download action
                  // You can implement the PDF download logic here
                  _launchPDF(widget.snap['PDF']);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.picture_as_pdf),
                    SizedBox(width: 8),
                    Text('Download PDF'),
                  ],
                ),
              )
            : Text('No PDF available'),
      ],
    );
  }
}
