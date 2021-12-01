import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: kWhiteColor),
      home: const LoginPage(),
    );
  }
}
