import 'package:flutter/material.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/controllers/input_reflect_controller.dart';
import 'package:provider/provider.dart';

class TodoUpdatePage extends StatelessWidget {
  final Todo? todo;
  final TodoController todoController;
  TodoUpdatePage({required this.todo, required this.todoController});

  @override
  Widget build(BuildContext context) {
    final InputReflectController inputReflectController = context.watch<InputReflectController>();
    String _text = inputReflectController.data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Todo'),
      ),
      body: Container(
        padding: EdgeInsets.all(61),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text("Before the change"),
            Text(todo!.todo, style: TextStyle(color: Colors.black),),
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
                  todoController.update(Todo(id: todo!.id, todo: _text, achieved: todo!.achieved));
                  Navigator.of(context).pop();
                },
                child: Text('Update the data', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 8,),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel', style: TextStyle(color: Colors.black),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
