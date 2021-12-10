import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/auth/forgot_password_page.dart';
import 'package:peka/ui/pages/auth/signup_page.dart';
import 'package:peka/ui/pages/home/home_page.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';

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
          progressIndicator: LottieBuilder.asset('assets/raw/loading.json'),
          isLoading: _isLoading,
          color: kGreyBgColor,
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
                      //TEXT MASUK
                      Text(
                        "Masuk",
                        style: blackTextStyle.copyWith(
                            fontSize: 22, fontWeight: medium),
                      ),
                      //TEXT SILAHKAN MASUK AKUN KAMU
                      Text(
                        "Silahkan masuk akun kamu",
                        style: greyTextStyle.copyWith(
                            fontSize: 14, fontWeight: light),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      //ILUSTRASI PADA HALAMAN LOGIN
                      Center(
                        child: SizedBox(
                          width: 220,
                          height: 220,
                          child: Image.asset(
                            'assets/images/ill_signin.png',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      //TEXT ALAMAT EMAIL
                      Text(
                        "Alamat Email",
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: medium),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      //TEXTFIELD ALAMAT EMAIL
                      CustomTextFormField(
                        hintText: 'Tulis alamat email kamu',
                        errorText: 'Masukkan alamat email kamu',
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      //TEXT KATA SANDI
                      Text(
                        "Kata Sandi",
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: medium),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      //TEXTFIELD KATA SANDI
                      CustomTextFormField(
                        hintText: 'Tulis kata sandi kamu',
                        errorText: 'Masukkan kata sandi kamu',
                        obscureText: true,
                        controller: _passwordController,
                      ),
                      // TEXT LUPA KATA SANDI
                      Align(
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
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //BUTTON MASUK
                      Button(
                        textButton: "Masuk",
                        onTap: _login,
                      ),
                      const SizedBox(height: 20.0),
                      //TEXT BELUM PUNYA AKUN? DAFTAR
                      Row(
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
                      )
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
      const snackBar = SnackBar(
          content: Text('Opss.. masukkan email/kata sandi dengan benar'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
