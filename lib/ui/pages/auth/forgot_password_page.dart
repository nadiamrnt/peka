import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_toast.dart';

import '../../../services/firebase/auth/auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  static const routeName = '/forgot-password-page';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
            child: Column(
              children: [
                _buildHeader(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                _buildIllustrasi(context),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                _buildEmail(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Button(
                  textButton: 'Atur Ulang Kata Sandi',
                  onTap: _sendResetPassword,
                )
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
        Text(
          "Lupa Sandi",
          style: blackTextStyle.copyWith(fontSize: 22, fontWeight: medium),
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
          'assets/images/ill_forgot_password.png',
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
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Tulis alamat email kamu",
                hintStyle: greyHintTextStyle,
                border: InputBorder.none,
              ),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
        ),
      ],
    );
  }

  Future<void> _sendResetPassword() async {
    try {
      _emailController.text.isNotEmpty
          ? await Auth.firebaseAuth
              .sendPasswordResetEmail(email: _emailController.text)
          : SmartDialog.showToast(
              '',
              widget:
                  const CustomToast(msg: 'Mohoh isi email anda', isError: true),
            );

      SmartDialog.showToast(
        '',
        widget: const CustomToast(msg: 'Mohoh periksa email anda'),
      );
    } catch (e) {
      e.toString() ==
              '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.'
          ? SmartDialog.showToast('',
              widget: const CustomToast(
                  msg: 'Email tidak terdaftar', isError: true))
          : SmartDialog.showToast(
              '',
              widget: const CustomToast(
                  msg: 'Terjadi kesalahan, coba lagi', isError: true),
            );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
