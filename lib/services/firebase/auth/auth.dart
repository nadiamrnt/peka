import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<User> signInEmail(String email, String password) async {
    UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }

  static Future<User> signUp(email, password) async {
    UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }
}
