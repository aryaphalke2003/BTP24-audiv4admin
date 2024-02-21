import 'dart:convert';

import 'package:audiadmin/HomePage.dart';
import 'package:flutter/material.dart';
import './shared/loading.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'models/userP.dart';
import 'services/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

// ignore: slash_for_doc_comments
/**
 * The page is to edit the profile page. That is edit the name of the user,
 * edit or add image, and also change the password.
 */
class _EditProfileState extends State<EditProfile> {
  //final AuthService _auth = AuthService();
  userP? user;
  File? _image;
  TextEditingController controlName = new TextEditingController();
  bool loading = false;
  bool loadingSubmit = false;
  String base_url = "https://arya09.pythonanywhere.com/";

  @override
  Widget build(BuildContext context) {
    //user = _auth.returnUser();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    user = userProvider.user;
    String tokenReq = "\"Token " + user!.token.toString() + "\"";

    final imagePath = user!.photoURL.toString();
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Your Profile"),
              elevation: 0,
            ),
            body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 40),
                  ProfileImage(imagePath, user, context),
                  SizedBox(height: 24),
                  editName(),
                  SizedBox(height: 40),
                  SubmitHere(),
                  ChangePassword(),
                ]),
            backgroundColor: const Color.fromARGB(255, 3, 60, 107)));
  }

  // Widget of password change button
  Widget ChangePassword() {
    return Column(children: <Widget>[
      const SizedBox(height: 20.0),
      TextButton(
          child: const Text(
            "Change my password",
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            // Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => PasswordChange()))
            //     .then((_) => setState(() {}));
          }),
    ]);
  }

  Widget SubmitHere() {
    return loadingSubmit
        ? Loading()
        : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink[400]),
            ),
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              setState(() => loadingSubmit = true);
              user?.setDisplayName(controlName.text);
              String tokenReq = "\"Token " + user!.token.toString() + "\"";
              var url =
                  base_url + "auth/update-profile/" + user!.uid.toString();
              var request = http.MultipartRequest('PUT', Uri.parse(url));
              print("URL: " + url);
              request.headers.addAll(<String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': tokenReq,
              });

              request.fields['name'] = user!.displayName.toString();
              request.files.add(await http.MultipartFile.fromPath(
                  'profile_pic', _image!.path));

              var response = await request.send();

              print("Response: " + response.statusCode.toString());
              print("Reason Phrase: " + response.reasonPhrase.toString());

              setState(() => loadingSubmit = false);

              var response2 = await http.get(Uri.parse(
                  base_url + "auth/all-users/" + user!.uid.toString()));
              if (response2.statusCode == 200) {
                var body = jsonDecode(response2.body);
                user?.setPhotoURL(body['profile_pic']);
              }

              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text('Profile Updated'),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ));
            });
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    controlName.dispose();
    super.dispose();
  }

  // Widget of name change test field
  Widget editName() {
    controlName = TextEditingController(text: user!.displayName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Full Name",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controlName,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 163, 154, 154), width: 1.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.person,
                color: Color.fromARGB(255, 0, 255, 200)),
            hintText: user!.displayName,
            hintStyle: TextStyle(color: Color.fromARGB(255, 185, 181, 181)),
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  // The function is responsible for picking the image from phone gallary
  Future getImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedfile;
    pickedfile = await picker.pickImage(source: ImageSource.gallery);
    print("Picked File: " + pickedfile!.path);
    setState(() => {
          if (pickedfile != null) {_image = File(pickedfile.path)}
        });
  }

  // photo display widget.
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

  // photo display from the firebase server.
  Widget buildImage(String imagePath, userP? user, context) {
    //print("Image: " + _image!.path);
    print("Image Path: " + imagePath!.toString());
    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: loading
                ? Loading()
                : Ink.image(
                    image: (_image != null)
                        ? FileImage(_image!) as ImageProvider
                        : (imagePath != "null")
                            ? NetworkImage(user!.photoURL.toString())
                            : const NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                    child: InkWell(onTap: () {
                      getImage();
                    }),
                  )));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
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
