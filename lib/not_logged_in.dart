import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/ui/pages/auth/login_page.dart';

class NotLoggedIn extends StatefulWidget {
  static const routeName = '/loggedin_screen';

  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  _NotLoggedInState createState() => _NotLoggedInState();
}

class _NotLoggedInState extends State<NotLoggedIn> {
  @override
  void initState() {
    super.initState();
    _splashScreenStart();
  }

  _splashScreenStart() async {
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
