import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/ui/pages/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenStart();
  }

  splashScreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigation.intentReplacement(LoginPage.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/img_logo.png', width: 250),
      ),
    );
  }
}
