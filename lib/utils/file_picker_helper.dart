import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:peka/services/firebase/auth/auth.dart';

Future<PlatformFile?> getFileAndUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Silahkan pilih surat keterangan panti asuhan anda!',
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc']);

  PlatformFile? filePath = result?.files.first;

  return filePath;
}

Future<String> documentFileUpload(String filePath) async {
  Reference ref = FirebaseStorage.instance
      .ref()
      .child('surat_keterangan')
      .child(Auth.firebaseAuth.currentUser!.uid)
      .child(filePath.split('/').last);

  UploadTask task = ref.putFile(File(filePath));
  TaskSnapshot snapShot = await task;
  return await snapShot.ref.getDownloadURL();
}
