import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'PROFIL PAGE',
            style: blackTextStyle.copyWith(fontSize: 40.0, fontWeight: bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Halaman ini dibuat hanya untuk keperluan pengetesan bottom navigasi',
            style: greyTextStyle.copyWith(fontSize: 20.0, fontWeight: light),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
