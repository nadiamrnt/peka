import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';

import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../widgets/button.dart';
import '../home/home_page.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup-page';

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: LoadingOverlay(
          isLoading: _isLoading,
          color: kGreyColor,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER HALAMAN SIGN UP
                    _buildHeader(),
                    const SizedBox(
                      height: 24.0,
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
                      height: 24.0,
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
                          child: CustomTextFormField(
                            controller: _firstNameController,
                            errorText: 'Mohon isi nama depan anda',
                            hintText: 'Nama depan',
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _lastNameController,
                            errorText: 'Mohon isi nama belakang anda',
                            hintText: 'Nama belakang',
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
                    CustomTextFormField(
                      hintText: 'Tulis alamat email kamu',
                      errorText: 'Mohon isi email anda',
                      controller: _emailController,
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
                    CustomTextFormField(
                      hintText: 'Tulis kata sandi kamu',
                      errorText: 'Mohon isi kata sandi anda',
                      controller: _password1Controller,
                      obscureText: true,
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
                    CustomTextFormField(
                      hintText: 'Tulis ulang kata sandi kamu',
                      errorText: 'Tulis masukkan lagi kata sandi anda',
                      controller: _password2Controller,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Button(
                      textButton: "Daftar",
                      onTap: _register,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigation.back();
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

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_formKey.currentState!.validate()) {
        if (_password1Controller.text != _password2Controller.text) {
          _password2Controller.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kata sandi tidak sesuai'),
            ),
          );
          setState(() {
            _isLoading = false;
          });
        } else {
          final name =
              "${_firstNameController.text} ${_lastNameController.text}";
          final email = _emailController.text;
          final password = _password1Controller.text;

          await Firestore.createUser(email, name, password);
          await Auth.signInEmail(email, password);
          Navigation.intentReplacement(HomePage.routeName);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Opss.. terjadi kesalahan'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }
}
