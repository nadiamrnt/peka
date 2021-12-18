import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String name;
  final String imageProfile;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.imageProfile});

  Map<String, dynamic> getDataMap() {
    return {
      "userId": userId,
      "email": email,
      "name": name,
      "img_profile": imageProfile,
    };
  }

  factory UserModel.getDataUser(DocumentSnapshot data) {
    return UserModel(
      userId: data.get('userId'),
      email: data.get('email'),
      name: data.get('name'),
      imageProfile: data.get('img_profile'),
    );
  }

  Map<String, dynamic> setDataMap() {
    return {
      "userId": userId,
      "email": email,
      "name": name,
      "img_profile": imageProfile,
    };
  }
}
