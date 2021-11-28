import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

import '../../widgets/button.dart';

class SignupPage extends StatelessWidget {
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
                // HEADER HALAMAN SIGN UP
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "assets/icons/ic_back_signup.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Daftar",
                          style: blackTextStyle.copyWith(
                              fontSize: 22, fontWeight: medium),
                        ),
                        Text(
                          "Silahkan buat akun kamu",
                          style: greyTextStyle.copyWith(
                              fontSize: 14, fontWeight: light),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //ILUSTRASI SIGN UP
                Center(
                  child: SizedBox(
                    width: 210,
                    height: 210,
                    child: Image.asset(
                      'assets/images/ill_signup.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //TEXT NAMA LENGKAP
                Text(
                  "Nama Lengkap",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: regular),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                //TEXT FIELD UNTUK NAMA DEPAN DAN NAMA BELAKANG
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
                const SizedBox(
                  height: 10.0,
                ),
                //TEXT ALAMAT EMAIL
                Text(
                  "Alamat Email",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: regular),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                //TEXTFIELD UNTUK ALAMAT EMAIL
                ConstrainedBox(
                  constraints: const BoxConstraints.tightForFinite(),
                  child: Container(
                    height: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: kGreyBgColor,
                        borderRadius:
                            BorderRadius.circular(defaultRadiusTextField)),
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: "Tulis alamat email kamu",
                            hintStyle: greyHintTextStyle,
                            border: InputBorder.none),
                        style: blackTextStyle.copyWith(
                            fontWeight: regular, fontSize: 14.0)),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //TEXT KATA SANDI
                Text(
                  "Kata Sandi",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: regular),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                //TEXTFIELD UNTUK KATA SANDI
                ConstrainedBox(
                  constraints: const BoxConstraints.tightForFinite(),
                  child: Container(
                    height: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: kGreyBgColor,
                        borderRadius:
                            BorderRadius.circular(defaultRadiusTextField)),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Tulis kata sandi kamu",
                            hintStyle: greyHintTextStyle,
                            border: InputBorder.none),
                        style: blackTextStyle.copyWith(
                            fontWeight: regular, fontSize: 14.0)),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //TEXT ULANG KATA SANDI
                Text(
                  "Ulang kata Sandi",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: regular),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                //TEXTFIELD UNTUK ULANG KATA SANDI
                ConstrainedBox(
                  constraints: const BoxConstraints.tightForFinite(),
                  child: Container(
                    height: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: kGreyBgColor,
                        borderRadius:
                            BorderRadius.circular(defaultRadiusTextField)),
                    child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Tulis ulang kata sandi kamu",
                            hintStyle: greyHintTextStyle,
                            border: InputBorder.none),
                        style: blackTextStyle.copyWith(
                            fontWeight: regular, fontSize: 14.0)),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Button(
                  textButton: "Daftar",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
