import 'package:flutter/material.dart';
import 'package:todo_test/pages/update_todo.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/controllers/input_reflect_controller.dart';
import 'package:todo_test/controllers/checkbox_controller.dart';
import 'package:provider/provider.dart';

class TodoCardVer2 extends StatelessWidget {
  final Todo todo;
  TodoCardVer2({required this.todo});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = context.read<TodoController>();
    bool _flag = todo.achieved;

    return Card(
      child: ListTile(
          leading: ChangeNotifierProvider<CheckboxController>(
            create: (_) => CheckboxController()..initial = _flag,
            child: _CheckBox(todo),
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
                        todo: todo, todoController: todoController),
                  );
                }));
              } else if (result == 'delete') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Really?"),
                        content:
                            Text("Are you sure you want to delete this data?"),
                        actions: <Widget>[
                          // ボタン領域
                          ElevatedButton(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
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

class _CheckBox extends StatelessWidget {
  final Todo todo;
  // bool flag;
  _CheckBox(this.todo);

  @override
  Widget build(BuildContext context) {
    CheckboxController controller = context.watch<CheckboxController>();
    TodoController todoController = context.read<TodoController>();
    return Checkbox(
      value: controller.data,
      // value: flag,
      onChanged: (value) {
        print(controller.data);
        // flag = value!;
        controller.change();
        todoController.changeAchievedVer2(todo);
      },
    );
  }
}
