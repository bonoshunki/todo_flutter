import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_test/controllers/firebase_auth.dart';
import 'package:todo_test/pages/home.dart';
import 'package:todo_test/pages/list_view_ver2.dart';
import 'package:todo_test/routes/auth/routes.dart';
import 'package:todo_test/routes/home/routes.dart';
import 'pages/auth_view.dart';
import 'package:todo_test/repositories/local/local_db.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();
  await Firebase.initializeApp();
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
      initialRoute: AuthRoutes.first,
      routes: {
        AuthRoutes.first: (context) => _FirstPage(),
        AuthRoutes.signUpEmail: (context) => SignUpEmailPage(),
        AuthRoutes.signInEmail: (context) => SignInEmailPage(),
        HomeRoutes.home: (context) => HomePage(),
        HomeRoutes.todoListVer2: (context) => TodoListPageVer2(),
      },
    );
  }
}

class _FirstPage extends StatelessWidget {
  static User? user = AuthController().auth.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user != null && user!.emailVerified) {
      return HomePage();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () async {
                Navigator.of(context).pushNamed(AuthRoutes.signInEmail);
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              child: const Text(
                'Sign up',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                Navigator.of(context).pushNamed(AuthRoutes.signUpEmail);
              },
            ),
          ],
        ),
      ),
    );
  }
}
