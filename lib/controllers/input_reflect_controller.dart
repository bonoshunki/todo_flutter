import 'package:flutter/material.dart';


class InputReflectController extends ChangeNotifier {
  String _text = '';

  String get data => _text;

  void input(String input) {
    _text = input;
    notifyListeners();
  }
}