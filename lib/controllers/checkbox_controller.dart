import 'package:flutter/material.dart';

class CheckboxController extends ChangeNotifier {
  bool? _flag = false;

  bool? get data => _flag;

  set initial (bool e) {
    _flag = e;
  }

  Future<void> change() async {
    _flag = !_flag!;
    notifyListeners();
  }
}