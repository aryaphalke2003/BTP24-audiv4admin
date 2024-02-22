import 'package:flutter/material.dart';

class ViewReq extends StatefulWidget {
  final dynamic snap;

  const ViewReq({required this.snap});

  @override
  _ViewReqState createState() => _ViewReqState();
}

class _ViewReqState extends State<ViewReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              // Buttons for approving and disapproving in the same row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle approving action
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Approve'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle disapproving action
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text('Disapprove'),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(16.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       IconButton(
      //         onPressed: () {
      //           // Handle approve action
      //         },
      //         icon: Icon(
      //           Icons.check,
      //           color: Colors.green,
      //           size: 40.0,
      //         ),
      //       ),
      //       SizedBox(width: 20),
      //       IconButton(
      //         onPressed: () {
      //           // Handle reject action
      //         },
      //         icon: Icon(
      //           Icons.close,
      //           color: Colors.red,
      //           size: 40.0,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
