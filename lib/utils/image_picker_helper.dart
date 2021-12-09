import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<XFile?> imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 80);

    return image;
  }

  static Future<XFile?> imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    return image;
  }
}
