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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: slash_for_doc_comments
/**
 * This is the teacher dashboard which displays all the posts in the 
 * teacher page. It currently displays all the posts in the database 
 * without any filter. It looops on all the posts and pass that into
 * PostCard widget.
 * Moreover, it also displays the buttons to add the post and quizzes and
 * logging out and visiting the profile.
 */
class _HomePageState extends State<HomePage> {
  PageController? _controller = PageController(initialPage: 0);
  bool isPressed = false;
  //final AuthService _auth = AuthService();

  //User? user;
  bool new_post = false;
  bool isEmailVerified = false;
  Timer? timer;
  userP? user;

  /// Initializes the class.
  /// Also initializes the timer, which keeps on checking every 3 seconds if the
  /// email is verified or not.
  void initState() {
    super.initState();
    //user = _auth.returnUser();
    //isEmailVerified = user!.emailVerified;
    // if (!isEmailVerified) {
    //   timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    //   if (isEmailVerified) {
    //     timer?.cancel();
    //   }
    // }
  }

  // Always dispose off the timer.
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //user = _auth.returnUser();
    //isEmailVerified = user!.emailVerified;
    // Posts getPost = Posts();
    Request getReq = Request();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Dashboard'),
        actions: <Widget>[
          Align(
            //alignment: const Alignment(0.9, -1),
            child: Container(
              child: IconButton(
                // the profile button
                icon: Icon(Icons.person),
                tooltip: "Profile",
                onPressed: () {
                  //setState(() => new_post = true);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                iconSize: 30,
                splashRadius: 37,
                splashColor: const Color.fromARGB(255, 3, 60, 107),
                // color: Colors.red,
              ),
            ),
          ),
          Container(
            child: IconButton(
              // the logout button
              onPressed: () {
                user?.setUid('null');
                user?.setDisplayName('Anonymous');
                user?.setPhotoURL(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => BaseApp()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout),
              tooltip: "logout",
            ),
          ),
        ],
      ),
      body: Stack(children: <Widget>[
        FutureBuilder<List>(
          future: getReq.getRequest(),
          builder: (context, snapshot) {
            return (snapshot.hasData && snapshot.data!.isNotEmpty)
                ? ListView.builder(
                    //     itemCount: snapshot.data!.docs.length,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => RequestCard(
                        snap:
                            snapshot.data![snapshot.data!.length - index - 1]),
                  )
                : const Center(
                    child: Text("No Posts currently available",
                        style: TextStyle(color: Colors.white)));
          },
        ),
        Align(
          alignment: const Alignment(0.9, 0.9),
          child: _getFAB(),
        ),
      ]),
    );
  }

  /// the function checls if the email is verified or not.
  Future checkEmailVerified() async {
    //user!.reload();
    // setState(() => {isEmailVerified = user!.emailVerified});
    // if (isEmailVerified) {
    //   timer?.cancel();
    // }
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: const Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF801E48),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (_) => UploadVid()));
            },
            label: 'Add Class',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: const Color(0xFF801E48)),
        // FAB 2
        SpeedDialChild(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF801E48),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => MakeQuiz(whichPage: "post")));
            },
            label: 'Add Subject',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: const Color(0xFF801E48)),

        SpeedDialChild(
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF801E48),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => MakeQuiz(whichPage: "quiz")));
            },
            label: 'Add Chapter',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: const Color(0xFF801E48)),
         ],
    );
  }
}
