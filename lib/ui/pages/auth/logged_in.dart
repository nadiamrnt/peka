import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/ui/pages/home/home_page.dart';

class LoggedIn extends StatefulWidget {
  static const routeName = '/notloggedin_screen';

  const LoggedIn({Key? key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
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
        Navigation.intentReplacement(HomePage.routeName);
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
