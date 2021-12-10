import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peka/data/model/user_model.dart';

import '../auth/auth.dart';

class Firestore {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static Future<void> createUser(
      String email, String name, String password) async {
    var user = await Auth.signUp(email, password);
    var userData =
        UserModel(userId: user.uid, name: name, email: email, imageProfile: '');

    firebaseFirestore.collection('users').doc(user.uid).set(
          userData.getDataMap(),
        );
  }
}
