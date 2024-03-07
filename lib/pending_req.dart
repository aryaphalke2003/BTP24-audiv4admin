import 'package:audiadmin/common_app_drawer.dart';
import 'package:flutter/material.dart';
import 'RequestCard.dart';
import './services/getRequest.dart';

class PendingRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Request getReq = Request();

    return CommonAppBarDrawer(
        title: 'Pending Requests',
        body: FutureBuilder<List>(
          future: getReq.getpendingRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is being fetched, you can show a loading indicator
              return Stack(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // If there's an error, you can handle it accordingly
              return Center(
                child: Text("Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.white)),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // If data is available, show the ListView
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => RequestCard(
                    type: "pending",
                    snap: snapshot.data![snapshot.data!.length - index - 1]),
              );
            } else {
              // If no data is available, show a message
              return Center(
                child: Text("No Pending Requests",
                    style: TextStyle(color: Color.fromARGB(255, 16, 1, 1))),
              );
            }
          },
        ));
  }
}
