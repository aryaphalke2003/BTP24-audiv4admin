// import 'package:flutter/material.dart';

// import 'getAudio.dart';
// import 'package:video_player/video_player.dart';
// import 'videoItems.dart';

// class AudioCard extends StatefulWidget {
//   final snap;
//   const AudioCard({required this.snap});

//   @override
//   _AudioCardState createState() => _AudioCardState();
// }

// // ignore: slash_for_doc_comments
// /**\
//  * This is the card that displays the title and image on the 
//  * audiobook page in the student page.
//  */
// class _AudioCardState extends State<AudioCard> {
//   int postLen = 0;
//   int index = 0;
//   Audios getaudio = Audios();
//   List <Duration> _sections = [];
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         widget.snap['AudioFile'].toString())
//       ..initialize().then((_) {
//         setState(() {
//           postLen = _controller.value.duration.inSeconds;
          
//           for (int i = 0; i < postLen; i += 600) {
//             _sections.add(Duration(seconds: i));
//           }
//         });
//       });

//     // Get the length of the video file and divide it into 5 parts
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     // getData();
//     return Column(children: [
//       Container(
//       height: _controller.value.isInitialized ? 200 : 50,
//       child: _controller.value.isInitialized ? VideoItems(
//         videoPlayerController: _controller,
//         looping: true,
//         autoplay: false,
//       ): CircularProgressIndicator(),
//       ),
//       SizedBox(height: 10),
//       ElevatedButton(
//         onPressed: () => {
//           setState(() {
//             index = (index - 1) % _sections.length;
//             _controller.seekTo(_sections[index]);
//           }),
//         },
//         child: Text('Previous Section'),
//       ),
//       ElevatedButton(
//         onPressed: () => {
//           setState(() {
//             index = (index + 1) % _sections.length;
//             _controller.seekTo(_sections[index]);
//           }),
//         },
//         child: Text('Next Section'),
//       ),
//     ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'videoItems.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: _controller.value.isInitialized ? 200 : 50,
          child: _controller.value.isInitialized
              ? VideoItems(
                  videoPlayerController: _controller,
                  looping: true,
                  autoplay: false,
                )
              : CircularProgressIndicator(),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              index = (index - 1) % _sections.length;
              _controller.seekTo(_sections[index]);
            });
          },
          child: Text('Previous Section'),
        ),
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
    );
  }
}