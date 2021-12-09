import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/splash_screen.dart';
import 'package:peka/ui/pages/auth/add_photo_page.dart';
import 'package:peka/ui/pages/auth/forgot_password_page.dart';
import 'package:peka/ui/pages/auth/login_page.dart';
import 'package:peka/ui/pages/auth/signup_page.dart';
import 'package:peka/ui/pages/category/category_page.dart';
import 'package:peka/ui/pages/detail/detail_page.dart';
import 'package:peka/ui/pages/home/home_page.dart';
import 'package:peka/ui/pages/home/search_page.dart';
import 'package:peka/ui/pages/kelola_panti/kelola_page.dart';
import 'package:peka/ui/pages/kelola_panti/register_page.dart';

import 'common/navigation.dart';

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
      navigatorKey: navigatorKey,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginPage.routeName: (context) => const LoginPage(),
        SignupPage.routeName: (_) => const SignupPage(),
        DetailPage.routeName: (_) => const DetailPage(),
        HomePage.routeName: (_) => const HomePage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
        KelolaPage.routeName: (_) => const KelolaPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
        SearchPage.routeName: (_) => const SearchPage(),
        AddPhotoPage.routeName: (_) => const AddPhotoPage(),
        ForgotPasswordPage.routeName: (_) => const ForgotPasswordPage(),
      },
    );
  }
}
