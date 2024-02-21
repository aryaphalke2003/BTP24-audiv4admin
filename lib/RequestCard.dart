import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/userP.dart';
import 'services/user_provider.dart';
import 'services/getRequest.dart';

class RequestCard extends StatefulWidget {
  final snap;

  const RequestCard({required this.snap});

  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  userP? user;
  int RequestLen = 0;
  Request getReq = Request();
  String imagePath = "";
  String downloadURL = "";
  String avatarPath = "";
  String author = "";
  String organization = "";

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    author = widget.snap["author"];
    organization = widget.snap["organization"];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new screen on card click
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SnapDetailsScreen(snap: widget.snap),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color:  Colors.white,
            width: 7.0,
          ),
          right: BorderSide(
            color: Colors.white,
            width: 7.0,
          ),
          top: BorderSide(
            color: Colors.white,
            width: 4.0,
          ),
          bottom: BorderSide(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
        child: FutureBuilder<String>(
          future: null,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 222, 235, 252),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.snap['Class'].toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 134, 11, 2),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(author,
                      style: const TextStyle(
                        color:
                            const Color.fromARGB(255, 53, 73, 83),
                        fontSize: 14,
                      )),
                  Text(organization,
                      style: const TextStyle(
                        color:
                            Color.fromARGB(255, 99, 99, 99),
                        fontSize: 12,
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// class SnapDetailsScreen extends StatelessWidget {
//   final dynamic snap;

//   const SnapDetailsScreen({required this.snap});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Snap Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display all details of the snap here
//             Text('Snap ID: ${snap['snapId']}'),
//             Text('Publish Time: ${snap['publishTime']}'),
//             // Add more details as needed
//             // Provide options for approving or disapproving
//             ElevatedButton(
//               onPressed: () {
//                 // Handle approving action
//               },
//               child: Text('Approve'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle disapproving action
//               },
//               child: Text('Disapprove'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class SnapDetailsScreen extends StatelessWidget {
  final dynamic snap;

  const SnapDetailsScreen({required this.snap});

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
              'Audiobook: ${snap["audiobookName"]}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Author: ${snap["audiobookAuthor"]}'),
            SizedBox(height: 20),
            // Display all details of the snap here
            Text('Snap ID: ${snap['snapId']}'),
            Text('Publish Time: ${snap['publishTime']}'),
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
