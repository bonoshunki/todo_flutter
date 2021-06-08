import 'package:flutter/material.dart';
import 'package:todo_test/controllers/firebase_auth.dart';
import 'package:todo_test/routes/auth/routes.dart';

class EmailValidationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email validation'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('I sent a verification mail to ' +
                AuthController().auth.currentUser!.email!),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(AuthRoutes.first));
              },
              child: Text('Verified'),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                AuthController().auth.currentUser!.sendEmailVerification();
              },
              child: Text('Resend verification mail'),
            ),
          ],
        ),
      ),
    );
  }
}
