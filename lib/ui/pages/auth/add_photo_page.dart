import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/home/home_page.dart';
import 'package:peka/ui/widgets/button.dart';

class AddPhotoPage extends StatelessWidget {
  const AddPhotoPage({Key? key}) : super(key: key);
  static const routeName = '/addphoto-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIconAdd(),
              const SizedBox(height: 40),
              _buildTextAndButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconAdd() {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 140,
        height: 140,
        child: Stack(
          children: [
            Image.asset(
              'assets/icons/ic_add_profile.png',
              width: 140,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/icons/ic_add.png',
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextAndButton() {
    return Column(
      children: [
        Text(
          'Tambahkan Foto Profil',
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
        ),
        const SizedBox(height: 12),
        Text(
          'Lengkapi profil kamu dengan \nmenambahkan foto profil',
          style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 70),
        SizedBox(
          width: 220,
          child: Button(
            textButton: 'Lanjutkan',
            onTap: () {
              Navigation.intentReplacement(HomePage.routeName);
            },
          ),
        ),
      ],
    );
  }
}
