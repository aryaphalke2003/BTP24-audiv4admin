import './signin.dart';
import './resetPassword.dart';
import 'package:flutter/material.dart';
import '../services/user_provider.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/userP.dart';
import 'package:audiadmin/data/repositories/mainserver_repository.dart';

class ResetPasswordOTP extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ResetPasswordOTP({Key? key}) : super(key: key);

  @override
  _ResetPasswordOTPState createState() => _ResetPasswordOTPState();
}

// ignore: slash_for_doc_comments
/**
 * The sign in page. 
 * User is required to sign in before continuining to the teacher page.
 * If the user is not registered, it has the option to sign up. Or if it is 
 * forgets its password, it has the option to reset the password. Firebase 
 * authentication is used for sign in.
 */
class _ResetPasswordOTPState extends State<ResetPasswordOTP> {
  //final AuthService _auth = AuthService();

  bool otpSent = false;
  bool loading = false;
  String email = "";
  String OTP = "";
  String error = "";
  final mainrepository = MainRepository();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
        child: loading
            ? Loading()
            : Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 100.0),
                              Ink.image(
                                image: const AssetImage(
                                    'asset/images/student.png'),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 30.0),
                              Column(children: const <Widget>[
                                Text(
                                  "Email Verification for ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'robotomono',
                                  ),
                                ),
                                Text(
                                  "Password Reset ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'robotomono',
                                  ),
                                ),
                              ]),
                              const SizedBox(height: 30.0),
                              TextFormField(
                                // enter email
                                decoration: inputTextDecoration.copyWith(
                                    hintText: 'Email'),
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
                                  setState(() => {
                                        email = val,
                                      });
                                },
                              ),
                              const SizedBox(height: 20.0),
                              Pinput(
                                length: 6,
                                showCursor: true,
                                onChanged: (value) => OTP = value,
                              ),
                              const SizedBox(height: 30.0),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        Size(250, 50)),
                                    backgroundColor: otpSent
                                        ? MaterialStateProperty.all(Colors.grey)
                                        : MaterialStateProperty.all(
                                            Colors.pink[400]),
                                  ),
                                  child: const Text(
                                    "Send OTP",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: otpSent
                                      ? null
                                      : () async {
                                          var response = await mainrepository
                                              .sentOTP(email);
                                          // Send OTP to the email using api call to https://nodemailer-test.onrender.com/sendmail?to=${email}
                                          // String url =
                                          //     "https://arya09.pythonanywhere.com:3000/sendmail?to=${email}";
                                          // var response =
                                          //     await http.get(Uri.parse(url));
                                          print(response!.body);
                                          setState(() {
                                            otpSent = true;
                                          });
                                        }),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        Size(250, 50)),
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor: otpSent
                                        ? MaterialStateProperty.all(
                                            Colors.pink[400])
                                        : MaterialStateProperty.all(
                                            Colors.grey),
                                  ),
                                  child: const Text(
                                    "Verify OTP",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: otpSent
                                      ? () async {
                                          String url =
                                              "https://nodemail-4l1d.onrender.com/verifyotp?email=${email}&otp=${OTP}";
                                          var response =
                                              await http.get(Uri.parse(url));
                                          print(response.body);
                                          userProvider
                                              .setUser(userP(uid: email));
                                          if (response.body == "OTP Verified") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPassword(
                                                          email: email)),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text('Email Verified!'),
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
                                                  Text('Invalid OTP!'),
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
                                        }
                                      : null),
                              const SizedBox(height: 20.0),
                              TextButton(
                                  child: const Text(
                                    "Already a user? Sign in here!",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignIn()));
                                  }),
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
