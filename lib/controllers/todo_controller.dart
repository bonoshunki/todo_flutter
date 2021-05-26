import 'package:flutter/material.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/repositories/local/todo.dart';

class TodoController extends ChangeNotifier {
  Todo? _todo;
  List<Todo> _todoList = [];

  List<Todo> get list => _todoList;

  Todo? get data => _todo;

  Future<void> retrieve() async {
    _todoList = await TodoRepository().retrieve();
    notifyListeners();
  }

  Future<void> retrieveOne(int id) async {
    _todo = await TodoRepository().retrieveOne(id);
    notifyListeners();
  }

  Future<void> create(Todo todo) async {
    await TodoRepository().create(todo);
    _todoList = await TodoRepository().retrieve();
    notifyListeners();
  }

  Future<void> update(Todo todo) async {
    await TodoRepository().update(todo);
    _todoList = await TodoRepository().retrieve();
    notifyListeners();
  }

  Future<void> changeAchieved(Todo todo) async {
    await TodoRepository().changeAchieved(todo);
    notifyListeners();
  }

  Future<void> changeAchievedVer2(Todo todo) async {
    await TodoRepository().changeAchieved(todo);
    // notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    await TodoRepository().delete(todo);
    _todoList = await TodoRepository().retrieve();
    notifyListeners();
  }
}
