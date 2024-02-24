import 'package:flutter/material.dart';
import './audiocard.dart';
import 'getAudio.dart';

class VideoScreen extends StatelessWidget {
  final String className;
  final String chapterName;
  final String subjectName;

  VideoScreen({required this.className, required this.chapterName, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    Audios getAudio = Audios();

    return Stack(
      children: [
        FutureBuilder<List>(
          future: getAudio.selectedAudio(className, chapterName, subjectName),
          builder: (context, snapshot) {
            return (snapshot.hasData && snapshot.data!.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => AudioCard(
                      snap: snapshot.data![snapshot.data!.length - index - 1],
                    ),
                  )
                : const Center(
                    child: Text(
                      "No Audiobooks currently available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
