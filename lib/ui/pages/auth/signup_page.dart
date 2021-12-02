import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';

import '../../widgets/button.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: SingleChildScrollView(
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
                    height: 20.0,
                  ),
                  Button(
                    textButton: "Daftar",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                  ),
                ],
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
