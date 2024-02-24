import 'package:audiadmin/audiocard.dart';
import 'package:flutter/material.dart';
import './videoplayer.dart';
import 'package:http/http.dart' as http;

class ViewReq extends StatefulWidget {
  final dynamic snap;

  const ViewReq({required this.snap});

  @override
  _ViewReqState createState() => _ViewReqState();
}

class _ViewReqState extends State<ViewReq> {
  void handleApprove(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Approval'),
          content: Text('Are you sure you want to approve this request?'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              icon: Icon(Icons.close, color: Colors.red),
            ),
            IconButton(
              onPressed: () {
                // Perform the approval action
                approveRequest();
                handleSnackBar(context, 'Request is approved!', 1);
                Navigator.pop(context); // Close the dialog
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        );
      },
    );
  }

  void handleDisapprove(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Disapproval'),
          content: Text('Are you sure you want to disapprove this request?'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              icon: Icon(Icons.close, color: Colors.red),
            ),
            IconButton(
              onPressed: () {
                // Perform the approval action
                disapproveRequest();
                handleSnackBar(context, 'Request is disapproved!', 2);
                Navigator.pop(context); // Close the dialog
              },
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        );
      },
    );
  }

  void approveRequest() async {
    // Move the request to the approved database
    // Implement this according to your database structure and method
    print("inapproval");
    String base_url = "http://127.0.0.1:8000/audiofiles/audiofiles";
    String ff = '$base_url/approve/${widget.snap["id"]}/';
    print("in ff $ff");
    var result = await http.post(
      Uri.parse(ff),
    );
    if (result.statusCode == 200) print("approved ");

    print(result.body);
  }

  void disapproveRequest() {
    // Move the request to the disapproved database
    // Implement this according to your database structure and method
  }

  void handleSnackBar(BuildContext context, String message, int i) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              i == 1 ? Icons.check_circle : Icons.disabled_by_default_outlined,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: i == 1 ? Colors.green : Colors.red,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

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
                'Audiobook: Class ${widget.snap["Class"]} ${widget.snap["ChapterName"]}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Author: ${widget.snap["description"]}'),
              SizedBox(height: 20),

              AudioCard(snap: widget.snap),

              SizedBox(height: 30),
              // Buttons for approving and disapproving in the same row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle approving action
                      handleApprove(context);
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
                      handleDisapprove(context);
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
