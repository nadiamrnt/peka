import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/ui/pages/auth/login_page.dart';
import 'package:peka/ui/pages/home/home_page.dart';

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
    bool isLogin = FirebaseAuth.instance.currentUser?.uid != null;
    splashScreenStart(isLogin);
  }

  splashScreenStart(bool isLogin) async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigation.intentReplacement(
            isLogin ? LoginPage.routeName : HomePage.routeName);
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
