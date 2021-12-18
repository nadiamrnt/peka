import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/user_model.dart';
import 'package:peka/services/firebase/auth/auth.dart';
import 'package:peka/services/firebase/firestore/firestore.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/ui/widgets/custom_toast.dart';
import 'package:peka/utils/firebase_storage_helper.dart';
import 'package:peka/utils/image_picker_helper.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/editprofile-page';

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool _isLoading = false;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: kGreyBgColor,
      progressIndicator: LottieBuilder.asset(
        'assets/raw/loading.json',
        width: 200,
      ),
      isLoading: _isLoading,
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.firebaseFirestore
            .collection('users')
            .doc(Auth.firebaseAuth.currentUser?.uid)
            .snapshots(),
        builder: (_, snapshot) {
          UserModel? user;
          if (snapshot.hasData) {
            user = UserModel.getDataUser(snapshot.data!);
            _firstNameController.text = user.name.split(" ").first;
            _lastNameController.text = user.name.split(" ").last;
          }

          if (snapshot.data == null) {
            return Center(
              child: LottieBuilder.asset(
                'assets/raw/loading.json',
                width: 200,
              ),
            );
          }

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 60),
                      _buildProfilePicture(user),
                      const SizedBox(height: 20),
                      _buildName(),
                      const SizedBox(height: 80),
                      Button(
                        textButton: 'Simpan Perubahan',
                        onTap: () {
                          setState(() {
                            Firestore.firebaseFirestore
                                .collection('users')
                                .doc(Auth.firebaseAuth.currentUser!.uid)
                                .update({
                              'name': _firstNameController.text +
                                  ' ' +
                                  _lastNameController.text
                            }).then((value) {
                              Navigation.back();
                              SmartDialog.showToast('',
                                  widget: const CustomToast(
                                    msg: 'Berhasil Mengubah Profil',
                                    isError: false,
                                  ));
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigation.back();
                },
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Expanded(
                child: Text(
                  'Edit Profil',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture(UserModel? user) {
    return GestureDetector(
      onTap: () async {
        _modalBottomSheetMenu();
      },
      child: user != null
          ? SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 140.0,
                      height: 140.0,
                      child: user.imageProfile.isNotEmpty
                          ? Image.network(
                              user.imageProfile,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/icons/ic_add_profile.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/icons/ic_pencil.png',
                        width: 45,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: _firstNameController,
          errorText: 'Mohon isi nama depan anda',
          hintText: 'Nama depan',
        ),
        const SizedBox(
          height: 15.0,
        ),
        CustomTextFormField(
          controller: _lastNameController,
          errorText: 'Mohon isi nama belakang anda',
          hintText: 'Nama belakang',
        ),
      ],
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (builder) {
        return Container(
          height: 150,
          padding: const EdgeInsets.only(
            top: 24,
            left: 70,
            right: 70,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: [
              Button(
                textButton: 'Ambil Foto',
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    await ImagePickerHelper.imgFromCamera().then((image) {
                      setState(() => _image = image);
                    });
                  } catch (e) {
                    SmartDialog.showToast('Ambil gambar dibatalkan');
                    setState(() => _isLoading = false);
                  }

                  if (_image != null) {
                    try {
                      // Send Image
                      String _imagePath = _image!.path.split('/').last;
                      Reference ref = FirebaseStorage.instance
                          .ref()
                          .child('image_profile')
                          .child(_imagePath);
                      UploadTask task = ref.putFile(_image!);
                      TaskSnapshot snapShot = await task;
                      String _imgUrl = await snapShot.ref.getDownloadURL();

                      await Firestore.firebaseFirestore
                          .collection('users')
                          .doc(Auth.firebaseAuth.currentUser!.uid)
                          .update({'img_profile': _imgUrl});
                    } catch (e) {
                      const CustomToast(
                        msg: 'Opss.. terjadi kesalahan',
                        isError: true,
                      );
                    }
                    Navigation.back();
                  }

                  setState(() => _isLoading = false);
                },
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () async {
                  setState(() => _isLoading = true);
                  try {
                    await ImagePickerHelper.imgFromGallery().then((image) {
                      setState(() => _image = image);
                    });
                  } catch (e) {
                    setState(() => _isLoading = true);
                    SmartDialog.showToast('Pilih gambar dibatalkan');
                  }

                  if (_image != null) {
                    try {
                      Navigation.back();
                      String _imgUrl =
                          await FirebaseStorageHelper.uploadImageProfile(
                              _image!);
                      await Firestore.firebaseFirestore
                          .collection('users')
                          .doc(Auth.firebaseAuth.currentUser!.uid)
                          .update({'img_profile': _imgUrl});
                    } catch (e) {
                      SmartDialog.showToast(
                        '',
                        widget:
                            const CustomToast(msg: 'Opss.. terjadi kesalahan'),
                      );
                    }
                  }

                  setState(() => _isLoading = false);
                },
                child: Text(
                  'Pilih dari galeri',
                  style:
                      greyTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
  }
}
