import 'package:flutter/material.dart';
import 'package:todo_test/pages/achieved_list_view.dart';
import 'package:todo_test/pages/add_todo.dart';
import 'package:todo_test/models/todo.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/controllers/input_reflect_controller.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/widgets/todo_card.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = context.watch<TodoController>();
    List<Todo> todoList = todoController.list;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List ver.1'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                //   return AchievedTodoListPage(todoList: todoList, todoController: todoController,);
                // }));
                // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //   return MultiProvider(
                //     providers: [
                //       ListenableProvider<TodoController>.value(
                //         value: todoController,
                //       ),
                //       Provider<List<Todo>>.value(
                //         value: todoList,
                //       )
                //     ],
                //     child: AchievedTodoListPage(),
                //   );
                  // return ListenableProvider<TodoController>.value(
                  //   value: todoController,
                  //   child: AchievedTodoListPage(todoList: todoList),
                  // );
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return ChangeNotifierProvider<TodoController>(
                    create: (_) => TodoController(),
                    child: AchievedTodoListPage(),
                  );
                }));
                // Navigator.push(
                //   MaterialPageRoute(
                //     builder: (context) => ListenableProvider<TodoController>.value(
                //       value: todoController,
                //       child: AchievedTodoListPage(todoList: todoList),
                //     ),
                //   ),
                // );
              }
          )
        ],
      ),
      body: _TodoListView(todoList: todoList),
      // _todoListView(todoList: todoList, todoController: todoController),
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
    );
  }
}



class _TodoListView extends StatelessWidget {
  final List<Todo> todoList;

  _TodoListView({required this.todoList});
   Widget build (BuildContext context) {
     // final TodoController todoController = context.read<TodoController>();
     // print(Scaffold.of(context));
     return Container(
       child: ListView.builder(
         itemCount: todoList.length,
         itemBuilder: (context, index) {
           // print(todoList[index].achieved);
           if (!todoList[index].achieved) {
             return TodoCard(todo: todoList[index]);
           } else {
             return Container();
           }
         },
       ),
     );
   }

}


// Widget _todoListView(
//     {required List<Todo> todoList, required TodoController todoController}) {
//   return ListView.builder(
//     itemCount: todoList.length,
//     itemBuilder: (context, index) {
//       // print(todoList[index].achieved);
//       if (todoList[index].achieved == 0) {
//         return Card(
//           child: ListTile(
//               leading: Radio(
//                   value: false,
//                   groupValue: '',
//                   activeColor: Colors.orange,
//                   onChanged: (value) {
//                     print(todoList[index].todo);
//                     todoController.achieved(todoList[index]);
//                     print(todoList[index].achieved);
//                   }
//               ),
//               title: Text(todoList[index].todo),
//               trailing: PopupMenuButton<String>(
//                 onSelected: (String result) async {
//                   if (result == 'update') {
//                     await Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return ChangeNotifierProvider<InputReflectController>(
//                         create: (_) => InputReflectController(),
//                         child: TodoUpdatePage(
//                             todo: todoList[index],
//                             todoController: todoController),
//                       );
//                     }));
//                     todoList[index] =
//                     await TodoRepository().retrieveOne(todoList[index].id);
//                   } else if (result == 'delete') {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text("Really?"),
//                             content: Text(
//                                 "Are you sure you want to delete this data?"),
//                             actions: <Widget>[
//                               // ボタン領域
//                               FlatButton(
//                                 child: Text("Cancel"),
//                                 onPressed: () => Navigator.pop(context),
//                               ),
//                               FlatButton(
//                                 child: Text("OK"),
//                                 onPressed: () {
//                                   todoController.delete(todoList[index]);
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ],
//                           );
//                         });
//                   }
//                 },
//                 itemBuilder: (BuildContext context) {
//                   return <PopupMenuItem<String>>[
//                     const PopupMenuItem<String>(
//                       value: 'update',
//                       child: Text("Update"),
//                     ),
//                     const PopupMenuItem<String>(
//                       value: 'delete',
//                       child: Text(
//                         "Delete",
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ];
//                 },
//               )),
//         );
//       } else {
//         return Container();
//       }
//     },
//   );
// }


// FutureBuilder(
// future: TodoRepository().retrieve(),
// future: todoController.retrieve(),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
//   if (snapshot.connectionState == ConnectionState.waiting) {
//     print('please wait...');
//     return Text("データ取得中");
//   } else {
//     print(todoList);
//     print("done");
//     return _todoListView(todoList: todoList);
//   }
// print(todoList[0].todo);
// if (snapshot.hasData) {
//   todoList = snapshot.data;
//   print('success');
//   return _todoListView(todoList: todoList);
// } else {
//   print('please wait...');
//   return Text("データ取得中");
// }
// }
