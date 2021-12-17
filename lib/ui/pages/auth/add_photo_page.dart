import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/services/firebase/firestore/firestore.dart';
import 'package:peka/ui/pages/home/home_page.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/toast.dart';
import 'package:peka/utils/firebase_storage_helper.dart';

import '../../../services/firebase/auth/auth.dart';
import '../../../utils/image_picker_helper.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);
  static const routeName = '/addphoto-page';

  @override
  State<AddPhotoPage> createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  bool _isLoading = false;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        color: kGreyBgColor,
        progressIndicator: LottieBuilder.asset('assets/raw/loading.json'),
        isLoading: _isLoading,
        opacity: 0.7,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIconAdd(),
                const SizedBox(height: 40),
                _buildTextAndButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconAdd() {
    return GestureDetector(
      onTap: () {
        _modalBottomSheetMenu();
      },
      child: SizedBox(
        width: 140,
        height: 140,
        child: Stack(
          children: [
            _image != null
                ? ClipOval(
                    child: Image.file(
                      _image!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  )
                : Image.asset(
                    'assets/icons/ic_add_profile.png',
                    width: 140,
                  ),
            _image != null
                ? const SizedBox()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/icons/ic_add.png',
                      width: 40,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextAndButton() {
    return Column(
      children: [
        Text(
          'Tambahkan Foto Profil',
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        const SizedBox(height: 12),
        Text(
          'Lengkapi profil kamu dengan \nmenambahkan foto profil',
          style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 70),
        SizedBox(
          width: 220,
          child: Button(
            textButton: 'Lanjutkan',
            onTap: () async {
              setState(() {
                _isLoading = true;
              });

              if (_image != null) {
                try {
                  // Send Image
                  String _imgUrl =
                      await FirebaseStorageHelper.uploadImageProfile(_image!);

                  // Send to Firestore
                  await Firestore.firebaseFirestore
                      .collection('users')
                      .doc(Auth.firebaseAuth.currentUser!.uid)
                      .update({'img_profile': _imgUrl});
                } catch (e) {
                  Toast(toastTitle: 'Opss.. terjadi kesalahan')
                      .failedToast()
                      .show(context);
                }
              }

              setState(() {
                _isLoading = false;
              });

              Navigation.intentReplacement(HomePage.routeName);
            },
          ),
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
                  await ImagePickerHelper.imgFromCamera().then((image) {
                    setState(() {
                      _image = image;
                    });
                  });
                  Navigation.back();
                },
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () async {
                  await ImagePickerHelper.imgFromGallery().then((image) {
                    setState(() {
                      _image = image;
                    });
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
