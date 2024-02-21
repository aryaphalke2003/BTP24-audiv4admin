import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: slash_for_doc_comments
/**
 * This is a constant for the pages where user needs to wait for 
 * some action to get completed. It is a rotating circle . 
 * It is used in multiple files like waiting to sign in or sign up.
 * It specifies some additional properties and decorations.
 */
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 3, 60, 107),
      child: const Center(
        child: SpinKitChasingDots(
          color: Color.fromARGB(255, 174, 219, 255),
          size: 50.0,
        ),
      ),
    );
  }
}
