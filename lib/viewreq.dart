import 'package:audiadmin/audiocard.dart';
import 'package:flutter/material.dart';
import './videoplayer.dart';
import 'package:http/http.dart' as http;
import './pending_req.dart';

class ViewReq extends StatefulWidget {
  final dynamic snap;
  final type;
  const ViewReq({required this.type, required this.snap});

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

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PendingRequestPage()),
                );
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PendingRequestPage()),
                );
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
    print("in approval");
    String url =
        "https://arya09.pythonanywhere.com/audiofiles/audiofiles/approve/${widget.snap["id"]}/";
    var result = await http.post(
      Uri.parse(url),
    );
    if (result.statusCode == 200) print("approved");

    print(result.body);
  }

  void disapproveRequest() async {
    // Move the request to the disapproved database
    // Implement this according to your database structure and method
    print("in disapproval");
    String url =
        "https://arya09.pythonanywhere.com/audiofiles/audiofiles/disapprove/${widget.snap["id"]}/";
    var result = await http.post(
      Uri.parse(url),
    );
    if (result.statusCode == 200) print("disapproved");

    print(result.body);
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
        duration: Duration(seconds: 4),
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
      body: Column(
        children: [
          // Title and Description at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Audiobook: Class ${widget.snap["Class"]} ${widget.snap["Subject"]} ${widget.snap["ChapterName"]}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Author: ${widget.snap["Author"]}',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Description: ${widget.snap["description"]}',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Reference: ${widget.snap["References"]}',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Gap for AudioCard
          Flexible(
            child: SizedBox(height: 20),
          ),

          // AudioCard
          Flexible(
            child: AudioCard(snap: widget.snap),
          ),

          // Buttons at the bottom
          widget.type == 'pending'
              ? Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
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
                    ],
                  ),
                )
              : widget.type == 'approved'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        'Approved By: ${widget.snap['approvedBy']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        'Rejected By: ${widget.snap['disapprovedBy']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
