import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static Database? _db;
  Database get instance => _db!;

  static Future<void> init() async {
    const scripts = {
      '2' : ['ALTER TABLE todo ADD COLUMN achieved INTEGER;'],
    };
    // await deleteDatabase(p.join(await getDatabasesPath(), 'local.db'));


    final path = p.join(await getDatabasesPath(), 'local.db');
    _db = await openDatabase(
        path,
        version: 2,
        onCreate: (Database newDb, int version) async {
          await newDb.execute(
            _LocalDBTables.config,
          );
          await newDb.execute(
            _LocalDBTables.todo,
          );
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          for (var i = oldVersion + 1; i <= newVersion; i++) {
            var queries = scripts[i.toString()];
            for (String query in queries!) {
              await db.execute(query);
            }
          }
        }
    );
    // await _db!.delete("todo");
  }
}

class _LocalDBTables {
  static const config = '''
   CREATE TABLE config
   (
     id INTEGER PRIMARY KEY,
     text TEXT,
     time INTEGER
   )
   ''';

  static const todo = '''
      CREATE TABLE todo
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        todo TEXT,
        achieved INTEGER
      )
    ''';
}
