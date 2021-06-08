// import 'package:sqflite/sqflite.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_test/controllers/firebase_auth.dart';
import 'package:todo_test/models/todo.dart';
// import 'package:todo_test/repositories/local/local_db.dart';

//コメントアウトしてあるのはローカルDB用
class TodoRepository {
  // final Database db = LocalDB().instance;
  final DatabaseReference db = FirebaseDatabase.instance
      .reference()
      .child(AuthController().auth.currentUser!.uid);

  Future<void> create(Todo todo) async {
    // await db.insert(
    //   'todo',
    //   todo.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
    int todoId = 0;
    await db.child('todoNumber').once().then(
      (DataSnapshot snapshot) {
        if (snapshot.value == null) {
          db.child('todoNumber').set({'number': 0});
        } else {
          todoId = snapshot.value['number'];
          todoId++;
          db.child('todoNumber').update({'number': todoId});
        }
      },
    );
    todo.id = todoId;
    db.child('todo').child(todoId.toString()).set(todo.toJson());
  }

  Future<List<Todo>> retrieve() async {
    // final List<Map<String, dynamic>> maps = await db.query('todo');
    // if (maps.isNotEmpty) {
    //   return List.generate(maps.length, (i) {
    //     bool achieved = maps[i]['achieved'] == 1 ? true : false;
    //     return Todo(
    //         id: maps[i]['id'], todo: maps[i]['todo'], achieved: achieved);
    //   });
    // } else {
    //   return [];
    // }
    List<Todo> todoList = [];
    await db.child('todo').once().then((DataSnapshot snapshot) {
      snapshot.value.forEach((value) {
        todoList.add(Todo.fromJson(Map<String, dynamic>.from(value)));
      });
    });
    return todoList;
  }

  Future<Todo> retrieveOne(int id) async {
    // final List<Map<String, dynamic>> todo =
    //     await db.query('todo', where: 'id = ?', whereArgs: [id]);
    // bool achieved = todo[0]['achieved'] == 1 ? true : false;
    // return Todo(id: todo[0]['id'], todo: todo[0]['todo'], achieved: achieved);
    Todo? todo;
    await db
        .child('todo')
        .child(id.toString())
        .once()
        .then((DataSnapshot snapshot) {
      todo = Todo.fromJson(Map<String, dynamic>.from(snapshot.value));
    });
    return todo!;
  }

  Future<void> update(Todo todo) async {
    // await db.update(
    //   'todo',
    //   todo.toMap(),
    //   where: "id = ?",
    //   whereArgs: [todo.id],
    //   // conflictAlgorithm: ConflictAlgorithm.fail,
    // );
    await db
        .child('todo')
        .child(todo.id.toString())
        .update(todo.toJson());
  }

  Future<void> changeAchieved(Todo todo) async {
    todo.achieved = !todo.achieved;
    // await db.update(
    //   'todo',
    //   todo.toMap(),
    //   where: "id = ?",
    //   whereArgs: [todo.id],
    //   // conflictAlgorithm: ConflictAlgorithm.fail,
    // );
    await db
        .child('todo')
        .child(todo.id.toString())
        .update({
          'achieved': todo.achieved
        });
  }

  Future<void> delete(Todo todo) async {
    // await db.delete(
    //   'todo',
    //   where: "id = ?",
    //   whereArgs: [todo.id],
    // );
    // db.child(todo.toJson())
    await db
        .child('todo')
        .child(todo.id.toString())
        .remove();
  }
}
