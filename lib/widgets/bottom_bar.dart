import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/kelola_panti_page/home_page.dart';
import 'package:peka/ui/kelola_panti_page/intro_kelola_page.dart';
import 'package:peka/ui/kelola_panti_page/profil_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
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
      const HomePage(),
      const IntroKelolaPage(),
      const ProfilPage()
    ];

    return Scaffold(
      body: _listPage.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 30.0),
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
              title: Text('Home', style: greyTextStyle),
            ),

            /// Kelola
            SalomonBottomBarItem(
              activeIcon: const ImageIcon(
                  AssetImage('assets/icons/ic_kelola_active.png')),
              icon: const ImageIcon(AssetImage('assets/icons/ic_kelola.png')),
              title: Text('Kelola', style: greyTextStyle),
            ),

            /// Profil
            SalomonBottomBarItem(
              activeIcon: const ImageIcon(
                  AssetImage('assets/icons/ic_profile_active.png')),
              icon: const ImageIcon(AssetImage('assets/icons/ic_profile.png')),
              title: Text('Profil', style: greyTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
