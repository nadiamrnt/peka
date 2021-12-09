import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/auth/add_photo_page.dart';

import '../../widgets/button.dart';

class SignupPage extends StatelessWidget {
  static const routeName = '/signup-page';

  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20.0),
                _buildIllustrasi(context),
                const SizedBox(height: 20.0),
                _buildNamaLengkap(),
                const SizedBox(height: 10.0),
                _buildAlamatEmail(),
                const SizedBox(height: 10.0),
                _buildKataSandi(),
                const SizedBox(height: 10.0),
                _buildUlangSandi(),
                const SizedBox(height: 20.0),
                Button(
                  textButton: "Daftar",
                  onTap: () {
                    Navigation.intentReplacement(AddPhotoPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/icons/ic_back_signup.png",
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(
          width: 26.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Daftar",
              style: blackTextStyle.copyWith(fontSize: 22, fontWeight: medium),
            ),
            Text(
              "Silahkan buat akun kamu",
              style: greyTextStyle.copyWith(fontSize: 14, fontWeight: light),
            )
          ],
        )
      ],
    );
  }

  Widget _buildIllustrasi(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 210,
        height: 210,
        child: Image.asset(
          'assets/images/ill_signup.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNamaLengkap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nama Lengkap",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45.0,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    color: kGreyBgColor,
                    borderRadius:
                        BorderRadius.circular(defaultRadiusTextField)),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Nama depan",
                        hintStyle: greyHintTextStyle,
                        border: InputBorder.none),
                    style: blackTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14.0)),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Container(
                height: 45.0,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    color: kGreyBgColor,
                    borderRadius:
                        BorderRadius.circular(defaultRadiusTextField)),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: "Nama belakang",
                        hintStyle: greyHintTextStyle,
                        border: InputBorder.none),
                    style: blackTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAlamatEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alamat Email",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          height: 45.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: kGreyBgColor,
              borderRadius: BorderRadius.circular(defaultRadiusTextField)),
          child: TextField(
              decoration: InputDecoration(
                  hintText: "Tulis alamat email kamu",
                  hintStyle: greyHintTextStyle,
                  border: InputBorder.none),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
        ),
      ],
    );
  }

  Widget _buildKataSandi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kata Sandi",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          height: 45.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: kGreyBgColor,
              borderRadius: BorderRadius.circular(defaultRadiusTextField)),
          child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Tulis kata sandi kamu",
                  hintStyle: greyHintTextStyle,
                  border: InputBorder.none),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
        ),
      ],
    );
  }

  Widget _buildUlangSandi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ulang kata Sandi",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          height: 45.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: kGreyBgColor,
              borderRadius: BorderRadius.circular(defaultRadiusTextField)),
          child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Tulis ulang kata sandi kamu",
                  hintStyle: greyHintTextStyle,
                  border: InputBorder.none),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
        ),
      ],
    );
  }
}
