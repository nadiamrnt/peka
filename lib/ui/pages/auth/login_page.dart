import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/auth/forgot_password_page.dart';
import 'package:peka/ui/pages/auth/signup_page.dart';
import 'package:peka/ui/pages/home/home_page.dart';

import '../../../common/navigation.dart';
import '../../widgets/button.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20.0),
                  _buildIlustrasi(context),
                  const SizedBox(height: 20.0),
                  _buildEmail(),
                  const SizedBox(height: 10.0),
                  _buildKataSandi(),
                  _buildLupaSandi(),
                  const SizedBox(height: 20.0),
                  Button(
                    textButton: "Masuk",
                    onTap: () {
                      Navigation.intent(HomePage.routeName);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  _buildDaftar(),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Masuk",
          style: blackTextStyle.copyWith(fontSize: 22, fontWeight: medium),
        ),
        Text(
          "Silahkan masuk akun kamu",
          style: greyTextStyle.copyWith(fontSize: 14, fontWeight: light),
        ),
      ],
    );
  }

  Center _buildIlustrasi(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Image.asset(
          'assets/images/ill_signin.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildEmail() {
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

  Widget _buildLupaSandi() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Navigation.intent(ForgotPasswordPage.routeName);
        },
        child: Text(
          "Lupa Sandi?",
          style: purpleTextStyle,
        ),
      ),
    );
  }

  Widget _buildDaftar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Belum punya akun?",
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: regular,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigation.intent(SignupPage.routeName);
          },
          child: Text(
            "Daftar",
            style: purpleTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        ),
      ],
    );
  }
}
