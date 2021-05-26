import 'package:flutter/material.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/controllers/input_reflect_controller.dart';
import 'package:provider/provider.dart';

class TodoAddPage extends StatelessWidget {
  final int? id;
  final TodoController todoController;
  TodoAddPage({required this.id, required this.todoController});

  @override
  Widget build(BuildContext context) {
    final InputReflectController inputReflectController = context.watch<InputReflectController>();
    String _text = inputReflectController.data;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(_text, style: TextStyle(color: Colors.black),),
            const SizedBox(height: 8,),
            TextField(
              onChanged: (String value) {
                  inputReflectController.input(value);
              },
            ),
            const SizedBox(height: 8,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  todoController.create(Todo(id: id!, todo: _text, achieved: false));
                  Navigator.of(context).pop();
                },
                child: const Text('Add to the list', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 8,),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.black),),
              ),
            )
          ],
        ),
      ),
    );
  }
}