import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * This file initializes the stack which is used to keep track of 
 * routes in the student app. It stores the routes which the user has 
 * already visited. This is then finally used to display particular chapters,
 * quizzes and posts.
 */
class CustomStack<E> {
  final _list = <E>[];
  void push(E value) => _list.add(value);
  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();

  int size() => _list.length;
}

final myStack = CustomStack<String>();
