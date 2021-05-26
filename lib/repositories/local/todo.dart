import 'package:todo_test/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_test/repositories/local/local_db.dart';

class TodoRepository {
  final Database db = LocalDB().instance;

  Future<void> create(Todo todo) async {
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> retrieve() async {
    final List<Map<String, dynamic>> maps = await db.query('todo');
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        bool achieved = maps[i]['achieved'] ==  1 ? true : false;
        return Todo(
            id: maps[i]['id'],
            todo: maps[i]['todo'],
            achieved: achieved
        );
      });
    } else {
      return [];
    }
  }

  Future<Todo> retrieveOne(int id) async {
    final List<Map<String, dynamic>> todo = await db.query('todo', where: 'id = ?', whereArgs: [id]);
    bool achieved = todo[0]['achieved'] ==  1 ? true : false;
    return Todo(
        id: todo[0]['id'],
        todo: todo[0]['todo'],
        achieved: achieved
    );
  }

  Future<void> update(Todo todo) async {
    await db.update(
      'todo',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
      // conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> changeAchieved(Todo todo) async {
    todo.achieved = !todo.achieved;
    await db.update(
      'todo',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
      // conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> delete(Todo todo) async {
    await db.delete(
      'todo',
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }


}
