import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/widgets/button.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  static const routeName = '/forgot-password-page';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              _buildIllustrasi(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              _buildEmail(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Button(
                textButton: 'Atur Ulang Kata Sandi',
                onTap: () {},
              )
            ],
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
}
