import 'package:flutter/material.dart';
import 'package:todo_test/pages/email_validation.dart';
import 'package:todo_test/controllers/firebase_auth.dart';
import 'package:todo_test/routes/auth/routes.dart';
import 'package:todo_test/routes/home/routes.dart';
import 'package:todo_test/widgets/auth_input.dart';


class SignUpEmailPage extends StatelessWidget {
  static String newEmail = '';
  static String newPass = '';

  void _setEmail(String value) {
    newEmail = value;
  }

  void _setPass(String value) {
    newPass = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputForm().emailAndPass(_setEmail, _setPass),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  AuthController().signUpWithEmail(newEmail, newPass);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EmailValidationPage();
                      },
                    ),
                  );
                  // Navigator.pop(context);
                } catch (e) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(AuthRoutes.first, (_) => false);
                }
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInEmailPage extends StatelessWidget {
  static String email = '';
  static String pass = '';

  void _setEmail(String value) {
    email = value;
  }

  void _setPass(String value) {
    pass = value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputForm().emailAndPass(_setEmail, _setPass),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              child: const Text('Sign in'),
              onPressed: () async {
                await AuthController().signInWithEmail(email, pass);
                if (AuthController().auth.currentUser!.emailVerified) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeRoutes.home, (_) => false);
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EmailValidationPage();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
