import 'package:flutter/material.dart';
import './editProfile.dart';
import 'models/userP.dart';
import 'services/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final AuthService _auth = AuthService();
  bool isEdit = false;
  userP? user;
  

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    user = userProvider.user;
    final imagePath = user!.photoURL.toString();
    setState(() {});

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Your Profile"),
              elevation: 0,
            ),
            body: ListView(physics: BouncingScrollPhysics(), children: [
              SizedBox(height: 200.0),
              ProfileImage(imagePath, user, context),
              SizedBox(height: 20.0),
              buildName(user)
            ]),
            backgroundColor: const Color.fromARGB(255, 3, 60, 107)));
  }

  Widget buildName(userP? user) => Column(
        children: [
          Text(
            user!.displayName.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            user.uid.toString(),
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4.0),
          Text(
            user.organization.toString(),
            style: TextStyle(color: Color.fromARGB(255, 115, 115, 115)),
          )
        ],
      );

  Widget ProfileImage(imagePath, user, context) {
    return Center(
        child: Stack(children: [
      buildImage(imagePath, user, context),
      Positioned(
        bottom: 0,
        right: 4,
        child: buildEditIcon(Colors.blue),
      ),
    ]));
  }

  Widget buildImage(String imagePath, userP? user, context) {
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: (imagePath != "null")
                  ? NetworkImage(user!.photoURL.toString())
                  : const NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
              fit: BoxFit.cover,
              width: 110,
              height: 110,
              child: InkWell(onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EditProfile()))
                    .then((_) => setState(() {}));
              }),
            )));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 15,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
