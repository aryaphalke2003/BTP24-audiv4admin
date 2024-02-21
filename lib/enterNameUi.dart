import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import './enterName.dart';
import './objective.dart';
import './shared/constants.dart';

// ignore: slash_for_doc_comments
/**
 * This is a statefulWidget for Entering the name of the user.
 * The user has the option to enter the name for more personalized experience
 * or skipping the entering of name. As most of our users are visually impaired,
 * hence we have chosen voice input for entering the name.
 */
class EnterName extends StatefulWidget {
  const EnterName({Key? key}) : super(key: key);

  @override
  _EnterNameState createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {
  String text = "Please press the button and speak your name.";
  bool isListening = false;
  @override
  Widget build(BuildContext context) {
    AppBar apbar = AppBar(
      title: const Text("Enter name"),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 33, 60, 127),
    );
    return Scaffold(
      appBar: apbar,
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(30),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                apbar.preferredSize.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage("asset/images/background.jpg"),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  fit: BoxFit.cover),
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromARGB(255, 4, 10, 77),
              //     Color.fromARGB(255, 21, 78, 126)
              //   ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   stops: [0.3, 0.7],
              // ),
            ),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(children: <Widget>[
                SizedBox(height: 100),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32.0,
                    color: Color.fromARGB(255, 243, 243, 244),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Objective()));
                      print(show_text);
                    },
                    child: Text('Next page', style: TextStyle(fontSize: 40)),
                    style: TextButton.styleFrom(
                      primary: Color.fromARGB(255, 240, 237, 237),
                      elevation: 2,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      onSurface: Colors.grey,
                      backgroundColor: Color.fromARGB(255, 33, 60, 127),
                    ))
              ]),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        endRadius: 100,
        glowColor: Color.fromARGB(255, 91, 151, 201),
        // child: Semantics(
        //   label: "mic button",
        child: TextButton(
          child: Semantics(
              label: "Mic",
              child:
                  Icon(isListening ? Icons.mic : Icons.mic_none, size: 80.0)),
          onPressed: toggleRecording,
          style: TextButton.styleFrom(
            primary: Color.fromARGB(255, 232, 229, 228),
            elevation: 2,
            backgroundColor:
                isListening ? Colors.blue : Color.fromARGB(255, 33, 60, 127),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Color.fromARGB(255, 248, 247, 247))),
          ),
        ),
      ),
    );
  }

  // ignore: slash_for_doc_comments
  /** 
   * a future for recording what the user is saying and then printing that 
   * on the screen.
   */
  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() {
          this.text = text;
          show_text = text;
        }),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);
        },
      );
}
