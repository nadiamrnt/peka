import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/authentication_page/signup_page.dart';
import 'package:peka/widgets/button.dart';

class LoginPage extends StatelessWidget {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TEXT MASUK
                Text(
                  "Masuk",
                  style:
                      blackTextStyle.copyWith(fontSize: 22, fontWeight: medium),
                ),
                //TEXT SILAHKAN MASUK AKUN KAMU
                Text(
                  "Silahkan masuk akun kamu",
                  style:
                      greyTextStyle.copyWith(fontSize: 14, fontWeight: light),
                ),
                const SizedBox(
                  height: 20.0,
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
                  height: 20.0,
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
                //TEXTFIELD ALAMAT EMAIL
                Container(
                  width: 312.0,
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
                //TEXTFIELD KATA SANDI
                Container(
                  width: 312.0,
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
                // TEXT LUPA KATA SANDI
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
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
                const Button(
                  textButton: "Masuk",
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ));
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
        ),
      ),
    );
  }
}
