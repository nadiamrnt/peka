import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static Future<String> uploadImageProfile(
    File file,
  ) async {
    String _imagePath = file.path.split('/').last;

    Reference ref =
        FirebaseStorage.instance.ref().child('image_profile').child(_imagePath);
    UploadTask task = ref.putFile(file);
    TaskSnapshot snapShot = await task;
    String _imgUrl = await snapShot.ref.getDownloadURL();
    return _imgUrl;
  }

  static Future<String> uploadImagePantiAsuhan(File file) async {
    String _imagePath = file.path.split('/').last;
    Reference ref =
        FirebaseStorage.instance.ref().child('image_panti').child(_imagePath);

    UploadTask task = ref.putFile(file);
    TaskSnapshot snapShot = await task;
    var _imgUrl = await snapShot.ref.getDownloadURL();
    return _imgUrl;
  }

  static Future<String> uploadImageDonation(File file) async {
    String _imagePath = file.path.split('/').last;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('image_donation')
        .child(_imagePath);

    UploadTask task = ref.putFile(file);
    TaskSnapshot snapShot = await task;
    var _imgUrl = await snapShot.ref.getDownloadURL();
    return _imgUrl;
  }
}
