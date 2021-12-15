import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../services/firebase/auth/auth.dart';

class ImagePickerHelper {
  static Future<File?> imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);
    File? compressedImage = await compressImage(File(image!.path));
    return compressedImage;
  }

  static Future<File?> imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    File? compressedImage = await compressImage(File(image!.path));
    return compressedImage;
  }

  static Future<File?> compressImage(File file) async {
    final String newPath = p.join((await getTemporaryDirectory()).path,
        '${Auth.firebaseAuth.currentUser!.uid}_${DateTime.now()}${p.extension(file.absolute.path)}');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      newPath,
      minHeight: 400,
      minWidth: 300,
      quality: 80,
    );

    return result;
  }
}
