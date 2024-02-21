import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * This is a constant for the decoration of the text input fields. 
 * It is used in multiple files for multiple text input fields.
 * It specifies some additional properties and decorations for the text
 * field.
 */
const inputTextDecoration = InputDecoration(
  fillColor: Color.fromARGB(255, 1, 47, 87),
  hintStyle: TextStyle(color: Colors.white),
  filled: true,
  contentPadding: EdgeInsets.all(20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
);

String show_text = "";
