import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/userP.dart';
import 'services/user_provider.dart';
import 'services/getRequest.dart';
import './viewreq.dart';

class RequestCard extends StatefulWidget {
  final snap;
  final type;

  const RequestCard({required this.type, required this.snap});

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
    user = userProvider.user ?? null;
    author = widget.snap["Author"] ?? "Anonymous";
    organization = "IIT Ropar";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a new screen on card click
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewReq(type: widget.type, snap: widget.snap),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.white,
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
                  Text(
                    'Class ${widget.snap['Class']} ${widget.snap['Subject']}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 134, 11, 2),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    author,
                    style: const TextStyle(
                      color: const Color.fromARGB(255, 53, 73, 83),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    organization,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 99, 99, 99),
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Chapter: ${widget.snap['ChapterName']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
