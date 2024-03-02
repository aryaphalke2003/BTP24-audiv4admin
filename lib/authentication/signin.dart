import 'dart:convert';

import 'package:audiadmin/authentication/signinOTP.dart';
import 'package:audiadmin/data/repositories/mainserver_repository.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import './resetPasswordOTP.dart';
import 'package:http/http.dart' as http;
import 'package:audiadmin/HomePage.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../models/userP.dart';

class SignIn extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

// ignore: slash_for_doc_comments
/**
 * The sign in page. 
 * User is required to sign in before continuining to the teacher page.
 * If the user is not registered, it has the option to sign up. Or if it is 
 * forgets its password, it has the option to reset the password. Firebase 
 * authentication is used for sign in.
 */
class _SignInState extends State<SignIn> {
  bool loading = false;
  String email = "aryaphalke2003@gmail.com";
  String password = "";
  String error = "";
  String base_url = "https://arya09.pythonanywhere.com/";
  final _formKey = GlobalKey<FormState>();
  final mainrepository = MainRepository();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return SafeArea(
        child: loading
            ? Loading()
            : Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                        child: Container(
                            child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 70.0),
                          Ink.image(
                            image: const AssetImage('asset/images/student.png'),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(children: const <Widget>[
                            Text(
                              "Admin Login",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'robotomono',
                              ),
                            ),
                          ]),
                          const SizedBox(height: 50.0),
                          TextFormField(
                            // enter email
                            decoration:
                                inputTextDecoration.copyWith(hintText: 'Email'),
                            style: const TextStyle(color: Colors.white),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter an email';
                              } else if (!val.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                                email = email.trim();
                              });
                            },
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            // enter password, Minimum 8 characters required for password
                            decoration: inputTextDecoration.copyWith(
                                hintText: 'Password'),
                            style: const TextStyle(color: Colors.white),
                            validator: (val) =>
                                val!.length < 8 ? 'Minimum 8 characters' : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.pink[400]),
                              ),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                // if(_formKey.currentState!.validate()){
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(
                                //         content: Row(
                                //           children: [
                                //             Icon(
                                //               Icons.error,
                                //               color: Colors.white,
                                //             ),
                                //             SizedBox(width: 8),
                                //             Text('Invalid details'),
                                //           ],
                                //         ),
                                //         backgroundColor: Colors.red.shade400,
                                //         duration: Duration(seconds: 4),
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.all(
                                //             Radius.circular(10),
                                //           ),
                                //         ),
                                //       )
                                //     );
                                //     return;
                                // }

                                // password is validated by using firebase in built functions.
                                // var response =
                                //     await mainrepository.login(email, password);
                                // print("Response: " +
                                //     response.statusCode.toString());
                                // print("Body: " + response.body);
                                // if (response.statusCode == 200)
                                if (true) {
                                  // var body = json.decode(response.body);
                                  userProvider.setUser(userP(uid: email));
                                  userProvider.setToken(
                                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFyeWFwaGFsa2UyMDAzQGdtYWlsLmNvbSIsImV4cCI6MTcwODY3MTIyNn0.Ewzdr7M791XwBHY-PlzEUZs6aieFsbxAi9qU0PI_-U0");
                                  userProvider.setDisplayName("arya");
                                  // print("Uid: " + userProvider.user!.uid);
                                  // print("Token: " + userProvider.user!.token);
                                  // print("Display Name: " + userProvider.user!.displayName);

                                  //if body contains photo url, set it
                                  // response = await http.get(Uri.parse(base_url +
                                  //     "auth/all-users/" +
                                  //     userProvider.user!.uid));
                                  // body = json.decode(response.body);
                                  // // print("Body: " + response.body);
                                  // // print("Response: " + response.statusCode.toString());
                                  // if (body['profile_pic'] != null) {
                                  //   print("Photo URL: " +
                                  //       body['profile_pic'].toString());
                                  //   userProvider
                                  //       .setPhotoURL(body['profile_pic']);
                                  // }

                                  // if (body['organization'] != null) {
                                  //   print("Organization: " +
                                  //       body['organization'].toString());
                                  //   userProvider
                                  //       .setOrganization(body['organization']);
                                  // }

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Sign in successful'),
                                      ],
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Invalid email or password'),
                                      ],
                                    ),
                                    backgroundColor: Colors.red.shade400,
                                    duration: Duration(seconds: 4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ));
                                }
                              }),
                          const SizedBox(height: 20.0),
                          TextButton(
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ResetPasswordOTP()));
                              }),
                          const SizedBox(height: 20.0),
                          Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ))),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 3, 60, 107)));
  }
}
