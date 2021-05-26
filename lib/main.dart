import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/pages/list_view.dart';
import 'package:todo_test/pages/list_view_ver2.dart';
import 'package:todo_test/repositories/local/local_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: _Home());
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text(
                'ver.1',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider<TodoController>(
                        create: (_) => TodoController()..retrieve(),
                        child: TodoListPage(),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 36,
            ),
            ElevatedButton(
              child: const Text(
                'ver.2',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider<TodoController>(
                        create: (_) => TodoController()..retrieve(),
                        child: TodoListPageVer2(),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
