import 'package:audiadmin/HomePage.dart';
import 'package:flutter/material.dart';
import './signin.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

// ignore: slash_for_doc_comments
/**
 * The authentication class which chooses if the user wants to Sign In or 
 * Sign Up. If the user wants to Sign Up, It is dirtected to the signup page,
 * else the sign in page. On each screen, there is a button to switch from one 
 * screen to other.
 */

class _AuthenticateState extends State<Authenticate> {
  // bool showSignIn = true;

  // void toggleView() {
  //   // Change between sign in and sign up screen
  //   setState(() => showSignIn = !showSignIn);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   if (showSignIn) {
  //     // If sign in page
  //     return const SignIn();
  //   } else {
  //     // If sign up page
  //     return const SignInOTP();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SignIn();
    // return HomePage();
  }
}
