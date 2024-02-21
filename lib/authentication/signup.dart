import 'package:audiadmin/data/repositories/mainserver_repository.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/loading.dart';
import './signin.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../services/user_provider.dart';
import '../models/userP.dart';

class SignUp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  final String email;
  const SignUp({Key? key, required this.email}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

// ignore: slash_for_doc_comments
/**
 * The sign up page. 
 * User is required to sign in before continuining to the teacher page.
 * If the user is not registered, it has the option to sign up.Firebase 
 * authentication is used for sign up. For personalised feed and to avoid 
 * spamming, teacher is required to enter its name and the email it enters 
 * is verified. On the verification page, every 3 seconds, it is checked if 
 * it has been verified. If verified, it is moved to the homepage automatically,
 * else it keeps on waiting for the user. User also has the option to change the
 * email while waiting for the email.
 */

class _SignUpState extends State<SignUp> {
  bool loading = false;
  String first_name = "";
  String password = "";
  String organization = "";
  String error = "";
  final mainrepository = MainRepository();
  final _formKey = GlobalKey<FormState>();
  String base_url = "https://arya09.pythonanywhere.com/";

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
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                          Column(children: const <Widget>[
                            Text(
                              "Join AudiBook Network ",
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
                            // enter name
                            decoration:
                                inputTextDecoration.copyWith(hintText: 'Name'),
                            style: TextStyle(color: Colors.white),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Name' : null,
                            onChanged: (val) {
                              setState(() => first_name = val);
                            },
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            // enter name
                            decoration: inputTextDecoration.copyWith(
                                hintText: 'Organization'),
                            style: TextStyle(color: Colors.white),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your organization' : null,
                            onChanged: (val) {
                              setState(() => organization = val);
                            },
                          ),
                          // const SizedBox(height: 5.0),
                          // TextFormField(
                          //   // enter valid email id
                          //   decoration:
                          //       inputTextDecoration.copyWith(hintText: 'Email'),
                          //   style: const TextStyle(color: Colors.white),
                          //   validator: (val) =>
                          //       val!.isEmpty ? 'Enter your Email' : null,
                          //   onChanged: (val) {
                          //     setState(() => email = val);
                          //   },
                          // ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            // enter password of minimum 8 characters
                            decoration: inputTextDecoration.copyWith(
                                hintText: 'Password'),
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            validator: (val) =>
                                val!.length < 8 ? 'Minimum 8 characters' : null,
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
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Post request to the server
                                  print("Email: " + widget.email);

                                  var response = await mainrepository.register(
                                      first_name,
                                      widget.email,
                                      organization,
                                      password);
                                  // var url =
                                  //     Uri.parse(base_url + "auth/register");
                                  // var response = await http.post(url, body: {
                                  //   "name": first_name,
                                  //   "email": widget.email,
                                  //   "organization": organization,
                                  //   "password": password
                                  // });

                                  if (response.statusCode == 201) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text('User created successfully'),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignIn()));
                                  } else if (response.statusCode == 400) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text('User already exists'),
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ));
                                  } else {
                                    // If the server did not return a 200 OK response,
                                    // then throw an exception.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text('User creation failed'),
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ));
                                  }
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
                                        Text('Please enter valid details'),
                                      ],
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ));
                                }

                                // dynamic result =
                                //     await _auth.registerWithEmailPassword(
                                //         first_name, email, password);
                                // setState(() => loading = true);
                                // if (result != "aa") {
                                //   setState(() {
                                //     error = result.toString();
                                //     loading = false;
                                //   });
                                // }
                              }),
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
                                        builder: (context) => const SignIn()));
                              }),
                          const SizedBox(height: 20.0),
                          Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 3, 60, 107)));
  }
}
