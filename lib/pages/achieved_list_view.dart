import 'package:flutter/material.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/widgets/todo_card.dart';

class AchievedTodoListPage extends StatelessWidget {
  // final List<Todo> todoList;
  // AchievedTodoListPage({required this.todoList});

  Widget build (BuildContext context) {
    // final List<Todo> todoList = context.read<List<Todo>>();
    // final TodoController todoController = context.read<TodoController>();
    final TodoController todoController = context.watch<TodoController>();
    List<Todo> todoList = todoController.list;
    if (todoList.isEmpty) {
      todoController.retrieve();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achieved Todo List'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          if (todoList[index].achieved) {
            return TodoCard(todo: todoList[index]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
