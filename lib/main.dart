// ignore_for_file: slash_for_doc_comments

import 'package:audiadmin/authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/user_provider.dart';
import 'shared/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: MaterialApp(
          home: BaseApp(),
          debugShowCheckedModeBanner: false,
          // routes
        ));
  }
}

/**
 * This is where the widgets of the app start. Here user chooses if he wants
 * to enter the student page or the teacher app. If it chooses the student page,
 * it is directed to the enter name page and if it is the teacher app, it is directed
 * to the teacher signin or HomePage.
 */
class BaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        if (myStack.isNotEmpty) myStack.pop();
        return true;
      },
      child: const SignIn(),
    );
  }
}
