import 'package:flutter/material.dart';
import '../services/user_provider.dart';
import './authenticate.dart';
import 'package:provider/provider.dart';
import '../HomePage.dart';

// ignore: slash_for_doc_comments
/**
 * The funntion is responsible for checking if the user is logged
 * in or not. If it is logged in, the user is directed directly to
 * the home page else the user is redirected to sign in or sign up.
 * depending on its choice.
 */
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    print("User is $user");
    print("Checking if user is null");
    if (user==null) {
      print("User is null");
      return Authenticate();
    } 
    else if(user!.uid == "null"){
      print("User is null");
      return Authenticate();
    }
    else {
      return HomePage();
    }
  }
}
