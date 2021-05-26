import 'package:flutter/material.dart';
import 'package:todo_test/pages/add_todo.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/models/tab.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/controllers/input_reflect_controller.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/widgets/todo_card_ver2.dart';

class TodoListPageVer2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = context.watch<TodoController>();
    final List<Todo> todoList = todoController.list;
    final List<TabInfo> _tabs = [
      TabInfo(
          'Not Achieved',
          _TodoListView(
            todoList: todoList,
          )),
      TabInfo(
          'Achieved',
          _AchievedTodoListView(
            todoList: todoList,
          ))
    ];

    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Todo List ver.2'),
            bottom: TabBar(
              tabs: _tabs.map((TabInfo tab) {
                return Tab(text: tab.label);
              }).toList(),
            ),
          ),
          body:
              // FutureBuilder(
              // future: todoController.retrieve(),
              // builder: (BuildContext context, AsyncSnapshot snapshot) {
              //   if (snapshot.connectionState == ConnectionState.waiting) {
              //     print('please wait...');
              //     return Text("データ取得中");
              //   } else {
              //     print(todoList);
              //     print("done");
              //     return TabBarView(children: _tabs.map((tab) => tab.widget).toList())
              //   ;
              // }
              // }),
              TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                int _id;
                if (todoList.isNotEmpty) {
                  _id = todoList.last.id + 1;
                } else {
                  _id = 0;
                }
                return ChangeNotifierProvider<InputReflectController>(
                  create: (_) => InputReflectController(),
                  child: TodoAddPage(
                    id: _id,
                    todoController: todoController,
                  ),
                );
              }));
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}

class _TodoListView extends StatelessWidget {
  final List<Todo> todoList;

  _TodoListView({required this.todoList});

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          if (!todoList[index].achieved) {
            return TodoCardVer2(todo: todoList[index]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _AchievedTodoListView extends StatelessWidget {
  final List<Todo> todoList;

  _AchievedTodoListView({required this.todoList});

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          // print(todoList[index].achieved);
          if (todoList[index].achieved) {
            return TodoCardVer2(todo: todoList[index]);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
