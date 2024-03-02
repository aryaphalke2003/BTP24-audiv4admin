import 'package:audiadmin/authentication/signin.dart';
import 'package:audiadmin/data/repositories/mainserver_repository.dart';
import 'package:flutter/material.dart';
import '../shared/loading.dart';
import '../shared/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  final String email;
  const ForgotPassword({Key? key, required this.email}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

// ignore: slash_for_doc_comments
/**
 * The page for the Forgot Password.
 * When the user forgots its password, it is asked to enter the email address.
 * If the email is correct and valid and is registered with the server, then an 
 * email is sent which contains the password reset link. Many a times, the email
 * is in the spam folder, hence a message is also shown to check the spam folder. 
 * if there is some error from the user side, the error is displayed.
 */
class ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  String password = "";
  String error = "";
  var base_url = "https://arya09.pythonanywhere.com/";
  final mainrepository = MainRepository();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: loading
            ? Loading()
            : Scaffold(
                resizeToAvoidBottomInset: false,
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                        child: Container(
                            child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 200.0),
                          Ink.image(
                            image: const AssetImage('asset/images/student.png'),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(children: const <Widget>[
                            Text(
                              "Reset your password",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'robotomono',
                              ),
                            ),
                          ]),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            decoration: inputTextDecoration.copyWith(
                                hintText: 'Password'),
                            style: const TextStyle(color: Colors.white),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your new password' : null,
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
                                "Send Request",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                var response = await mainrepository
                                    .forgotPassword(widget.email, password);

                                print(response.body);
                                print(response.statusCode);

                                if (response.statusCode == 200) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignIn()));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Password reset successful'),
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
                                        Text('Password reset failed'),
                                      ],
                                    ),
                                    backgroundColor: Colors.red,
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
