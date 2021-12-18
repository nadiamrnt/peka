import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/kelola_panti/kelola_page.dart';
import 'package:peka/ui/pages/profile/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../services/connectivity_status.dart';
import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
    _source.clear();
  }

  int _selectedIndex = 0;

  void _onNavbarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //LIST PAGE UNTUK NAVIGASI PINDAH HALAMAN
    List<Widget> _listPage = [
      const HomePageContent(),
      const KelolaPage(),
      const ProfilePage()
    ];

    return Scaffold(
      body: _source.keys.isEmpty
          ? Center(
              child: LottieBuilder.asset(
                'assets/raw/loading.json',
                width: 200,
              ),
            )
          : _source.keys.toList()[0] == ConnectivityResult.none
              ? _buildNoInternet()
              : _listPage.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
        child: SalomonBottomBar(
          onTap: _onNavbarTapped,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kPrimaryColor,
          currentIndex: _selectedIndex,
          items: [
            /// Home
            SalomonBottomBarItem(
              activeIcon: const ImageIcon(
                  AssetImage('assets/icons/ic_home_active.png')),
              icon: const ImageIcon(AssetImage('assets/icons/ic_home.png')),
              title: Text(
                'Home',
                style: greyTextStyle.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),

            /// Kelola
            SalomonBottomBarItem(
              activeIcon: const ImageIcon(
                  AssetImage('assets/icons/ic_kelola_active.png')),
              icon: const ImageIcon(AssetImage('assets/icons/ic_kelola.png')),
              title: Text(
                'Kelola',
                style: greyTextStyle.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),

            /// Profil
            SalomonBottomBarItem(
              activeIcon: const ImageIcon(
                  AssetImage('assets/icons/ic_profile_active.png')),
              icon: const ImageIcon(AssetImage('assets/icons/ic_profile.png')),
              title: Text(
                'Profile',
                style: greyTextStyle.copyWith(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoInternet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/ill_no_internet.png', width: 250),
          const SizedBox(height: 12),
          Text(
            'Opss sepertinya\nTidak ada internet',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
