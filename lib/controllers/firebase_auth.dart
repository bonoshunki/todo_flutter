import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  static AuthController _cache = AuthController._();

  AuthController._();
  factory AuthController() {
    return _cache;
  }

  FirebaseAuth get auth => FirebaseAuth.instance;

  Future<void> signUpWithEmail(String email, String pass) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      await auth.currentUser!.sendEmailVerification();
    } catch (error) {
      print(error);
      throw error;
    }
    // on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is to
    //o weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } on Exception catch (e) {
    //   print(e);
    // }
    // final UserCredential userInfo = await auth.createUserWithEmailAndPassword(email: email, password: pass);
    // return User user = userInfo.user!;
  }

  Future<void> signInWithEmail(String email, String pass) async {
    await auth.signInWithEmailAndPassword(email: email, password: pass);
    print(auth.currentUser);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
