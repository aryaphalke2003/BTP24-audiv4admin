import 'package:flutter/material.dart';
import './pending_req.dart';
import './profile.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'models/userP.dart';
import 'package:audiadmin/services/user_provider.dart';
import 'package:audiadmin/services/getRequest.dart';
import 'main.dart';
import './profile.dart';
import './RequestCard.dart';
import './screens/addgrade.dart';
import './screens/addsubject.dart';
import './screens/addchapter.dart';
import './pending_req.dart';
import './approved_req.dart';
import './disapproved_req.dart';

class CommonAppBarDrawer extends StatelessWidget {
  final String title;
  final Widget body;
  userP? user;

  CommonAppBarDrawer({required this.title, required this.body});

  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState
                ?.openDrawer(); // Use the key to access the Scaffold's state
          },
        ),
        title: Text(title),
        actions: [
          // Add this action to place the logo at the end of the AppBar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'asset/images/app_logo_blue.png',
              width: 30,
              height: 30,
              // You can adjust width and height based on your requirements
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 193, 0, 97),
                ),
                child: Container(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  margin: EdgeInsets.only(top: 20),
                ),
              ),
            ),

            ListTile(
              title: Text('Pending Requests'),
              leading: Icon(Icons.arrow_forward_ios_outlined, size: 20),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PendingRequestPage()),
                );
              },
            ),

            ListTile(
              title: Text('Approved Requests'),
              leading: Icon(Icons.arrow_forward_ios_outlined, size: 20),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ApprovedRequestPage()),
                );
              },
            ),

            ListTile(
              title: Text('Rejected Requests'),
              leading: Icon(Icons.arrow_forward_ios_outlined, size: 20),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DisapprovedRequestPage()),
                );
              },
            ),

            ListTile(
              title: Text('Add Grade'),
              leading: Icon(Icons.add, size: 20),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddGrade()),
                );
              },
            ),
            ListTile(
              title: Text('Add Subject'),
              leading: Icon(Icons.add, size: 20),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddSubject()),
                );
              },
            ),
            ListTile(
              title: Text('Add Chapter'),
              leading: Icon(Icons.add, size: 20),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddChapter()),
                );
              },
            ),

            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person, size: 20),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout, size: 20),
              title: Text('Logout'),
              onTap: () {
                // Logout the user
                user?.setUid('null');
                user?.setDisplayName('Anonymous');
                user?.setPhotoURL(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => BaseApp()),
                    (route) => false);
              },
            ),
            // ... (other ListTiles)
          ],
        ),
      ),
      body: body,
    );
  }
}
