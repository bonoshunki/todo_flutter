import 'package:flutter/material.dart';
import 'package:todo_test/pages/update_todo.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/controllers/input_reflect_controller.dart';
import 'package:provider/provider.dart';


class TodoCard extends StatelessWidget {
  final Todo todo;
  TodoCard({required this.todo});


  @override
  Widget build(BuildContext context) {
    // final BuildContext context2 = context;
    final TodoController todoController = context.read<TodoController>();
    // final TodoController todoController = context.watch<TodoController>();
    bool _flag = todo.achieved;

    return Card(
      child: ListTile(
          // leading: Radio(
          //     value: true,
          //     groupValue: '',
          //     // activeColor: Colors.orange,
          //     onChanged: (value) {
          //       todoController.changeAchieved(todo);
          //     }
          // ),
        leading: Checkbox(
          value: _flag,
          onChanged: (value) {
            // _flag = value!;
            // print(_flag);
            // todoController.notify();
            todoController.changeAchieved(todo);
          },
        ),
          title: Text(todo.todo),
          trailing: PopupMenuButton<String>(
            onSelected: (String result) async {
              if (result == 'update') {
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ChangeNotifierProvider<InputReflectController>(
                    create: (_) => InputReflectController(),
                    child: TodoUpdatePage(
                        todo: todo,
                        todoController: todoController),
                  );
                }));
              } else if (result == 'delete') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Really?"),
                        content: Text(
                            "Are you sure you want to delete this data?"),
                        actions: <Widget>[
                          // ボタン領域
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              todoController.delete(todo);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: 'update',
                  child: Text("Update"),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ];
            },
          )),
    );
  }
}