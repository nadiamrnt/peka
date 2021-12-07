import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/auth/login_page.dart';
import 'package:peka/ui/pages/auth/signup_page.dart';
import 'package:peka/ui/pages/detail/detail_map_page.dart';
import 'package:peka/ui/pages/detail/detail_page.dart';
import 'package:peka/ui/pages/home/category/category_page.dart';
import 'package:peka/ui/pages/home/home_page.dart';
import 'package:peka/ui/pages/kelola_panti/kelola_page.dart';
import 'package:peka/ui/pages/kelola_panti/register_page.dart';
import 'package:peka/ui/pages/maps/google_maps_page.dart';

import 'common/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      /*initialRoute: FirebaseAuth.instance.currentUser?.uid != null
          ? LoginPage.routeName
          : HomePage.routeName,*/
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        SignupPage.routeName: (_) => const SignupPage(),
        DetailPage.routeName: (_) => const DetailPage(),
        HomePage.routeName: (_) => const HomePage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
        KelolaPage.routeName: (_) => const KelolaPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
        GoogleMapsPage.routeName: (_) => const GoogleMapsPage(),
        DetailMapPage.routeName: (_) => const DetailMapPage(),
      },
    );
  }
}
