import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';

import '../../../common/navigation.dart';
import '../../../data/model/user_model.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../../utils/image_picker_helper.dart';
import '../../widgets/button.dart';
import '../../widgets/profile_option.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: kGreyBgColor,
      progressIndicator: LottieBuilder.asset('assets/raw/loading.json'),
      isLoading: _isLoading,
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.firebaseFirestore
            .collection('users')
            .doc(Auth.auth.currentUser?.uid)
            .snapshots(),
        builder: (_, snapshot) {
          UserModel? user;
          if (snapshot.hasData) {
            user = UserModel.getDataUser(snapshot.data!);
          }

          if (snapshot.data == null) {
            return Center(
              child: LottieBuilder.asset('assets/raw/loading.json'),
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
                      const SizedBox(height: 40),
                      _buildProfilePicture(user),
                      const SizedBox(height: 20),
                      _buildName(user),
                      const SizedBox(height: 40),
                      _buildOptionList(context),
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
      padding:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
      child: Center(
        child: Text(
          'Profil',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
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
              width: 140,
              height: 140,
              child: Stack(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 120.0,
                      height: 120.0,
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
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/icons/ic_pencil.png',
                        width: 40,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildName(UserModel? user) {
    return Column(
      children: [
        Text(
          user != null ? user.name : '',
          style: blackTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          user != null ? user.email : '',
          style: greyTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: regular,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionList(BuildContext context) {
    return Column(
      children: [
        ProfileOption(
          imageAsset: 'ic_edit_profile.png',
          title: 'Edit Profil',
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        ProfileOption(
          imageAsset: 'ic_setting.png',
          title: 'Pengaturan',
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        ProfileOption(
          imageAsset: 'ic_info.png',
          title: 'Tentang Kami',
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        ProfileOption(
          imageAsset: 'ic_logout.png',
          title: 'Keluar',
          onTap: () async {
            await Auth.auth.signOut();
            Navigation.intentReplacement(LoginPage.routeName);
          },
        ),
        const SizedBox(height: 5),
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

                  await ImagePickerHelper.imgFromCamera().then((image) {
                    setState(() {
                      _image = image;
                    });
                  });
                  if (_image != null) {
                    try {
                      // Send Image
                      String _imagePath = _image!.path.split('/').last;
                      Reference ref = FirebaseStorage.instance
                          .ref()
                          .child('image_profile')
                          .child(_imagePath);
                      UploadTask task = ref.putFile(File(_image!.path));
                      TaskSnapshot snapShot = await task;
                      String _imgUrl = await snapShot.ref.getDownloadURL();

                      await Firestore.firebaseFirestore
                          .collection('users')
                          .doc(Auth.auth.currentUser!.uid)
                          .update({'img_profile': _imgUrl});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opss.. terjadi kesalahan'),
                        ),
                      );
                    }
                  }

                  setState(() {
                    _isLoading = false;
                  });

                  Navigation.back();
                },
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await ImagePickerHelper.imgFromGallery().then((image) {
                    setState(() {
                      _image = image;
                    });
                  });
                  if (_image != null) {
                    try {
                      // Send Image
                      String _imagePath = _image!.path.split('/').last;
                      Reference ref = FirebaseStorage.instance
                          .ref()
                          .child('image_profile')
                          .child(_imagePath);
                      UploadTask task = ref.putFile(File(_image!.path));
                      TaskSnapshot snapShot = await task;
                      String _imgUrl = await snapShot.ref.getDownloadURL();

                      await Firestore.firebaseFirestore
                          .collection('users')
                          .doc(Auth.auth.currentUser!.uid)
                          .update({'img_profile': _imgUrl});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opss.. terjadi kesalahan'),
                        ),
                      );
                    }
                  }

                  setState(() {
                    _isLoading = false;
                  });

                  Navigation.back();
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
}
