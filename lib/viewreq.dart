import 'package:flutter/material.dart';


class ViewReq extends StatefulWidget {
  final dynamic snap;

  const ViewReq({required this.snap});

  @override
  _ViewReqState createState() => _ViewReqState();
}

class _ViewReqState extends State<ViewReq> {

  @override
  void initState() {
    super.initState();
  }

  // Add your play audio function here
  void playAudio() {
    // Implement your audio playback logic here
    // You can use packages like audioplayers for audio playback
  }

  // Add your PDF download function here
  void downloadPdf() {
    // Implement your PDF download logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snap Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display audiobook name and author at the top
            Text(
              'Audiobook: ${widget.snap["audiobookName"]}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Author: ${widget.snap["audiobookAuthor"]}'),
            SizedBox(height: 20),
            // Display all details of the snap here
            Text('Snap ID: ${widget.snap['snapId']}'),
            Text('Publish Time: ${widget.snap['publishTime']}'),
            // Add more details as needed
            SizedBox(height: 20),
            // Buttons for approving, disapproving, playing audio, and downloading PDF
            ElevatedButton(
              onPressed: () {
                // Handle approving action
              },
              child: Text('Approve'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle disapproving action
              },
              child: Text('Disapprove'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call play audio function
                playAudio();
              },
              child: Text('Play Audio'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call download PDF function
                downloadPdf();
              },
              child: Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
