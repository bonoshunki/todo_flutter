import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test/controllers/firebase_auth.dart';
import 'package:todo_test/controllers/todo_controller.dart';
import 'package:todo_test/routes/auth/routes.dart';
import 'list_view.dart';
import 'list_view_ver2.dart';

class HomePage extends StatelessWidget {
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
            const SizedBox(
              height: 48,
            ),
            ElevatedButton(
              child: const Text(
                'Sign out',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () async {
                await AuthController().auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthRoutes.first, (_) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
