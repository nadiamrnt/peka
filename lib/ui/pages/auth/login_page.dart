import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/auth/forgot_password_page.dart';
import 'package:peka/ui/pages/auth/signup_page.dart';
import 'package:peka/ui/pages/home/home_page.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/ui/widgets/custom_toast.dart';

import '../../../common/navigation.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../widgets/button.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: LoadingOverlay(
          progressIndicator: LottieBuilder.asset(
            'assets/raw/loading.json',
            width: 200,
          ),
          isLoading: _isLoading,
          color: kGreyBgColor,
          opacity: 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
              child: Stack(children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24.0),
                      _buildIlustration(context),
                      const SizedBox(height: 24.0),
                      _buildEmail(),
                      const SizedBox(height: 10.0),
                      _buildPassword(),
                      _buildForgotPassword(),
                      const SizedBox(height: 20.0),
                      Button(
                        textButton: "Masuk",
                        onTap: _login,
                      ),
                      const SizedBox(height: 20.0),
                      _buildSignUp()
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUp() {
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

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigation.intent(ForgotPasswordPage.routeName);
        },
        child: Text(
          "Lupa Sandi?",
          style: purpleTextStyle,
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kata Sandi",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
        const SizedBox(
          height: 5.0,
        ),
        CustomTextFormField(
          hintText: 'Tulis kata sandi kamu',
          errorText: 'Masukkan kata sandi kamu',
          obscureText: true,
          controller: _passwordController,
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alamat Email",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
        const SizedBox(
          height: 5.0,
        ),
        CustomTextFormField(
          hintText: 'Tulis alamat email kamu',
          errorText: 'Masukkan alamat email kamu',
          controller: _emailController,
        ),
      ],
    );
  }

  Widget _buildIlustration(BuildContext context) {
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

  Widget _buildHeader() {
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final email = _emailController.text;
        final password = _passwordController.text;

        await Auth.signInEmail(email, password);

        Navigation.intentReplacement(HomePage.routeName);
      }
    } catch (e) {
      if (e.toString() ==
          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
        SmartDialog.showToast(
          '',
          widget: const CustomToast(
            msg: 'Masukkan kata sandi dengan benar',
            isError: true,
          ),
        );
      } else if (e.toString() ==
          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
        SmartDialog.showToast(
          '',
          widget: const CustomToast(
            msg: 'Email tidak ditemukan',
            isError: true,
          ),
        );
      } else if (e.toString() ==
          '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        SmartDialog.showToast(
          '',
          widget: const CustomToast(
            msg: 'Tidak ada koneksi internet',
            isError: true,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
