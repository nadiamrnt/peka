import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Expanded(
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildProfilePicture(),
                  const SizedBox(height: 20),
                  _buildName(),
                  const SizedBox(height: 40),
                  _buildOptionList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
      child: Center(
        child: Text(
          'Profile',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SizedBox(
        width: 120.0,
        height: 120.0,
        child: Image.asset(
          'assets/images/img_profile.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildName() {
    return Column(
      children: [
        Text(
          "Muhammad Ridhoi",
          style: blackTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'r.ridoi702@gmail.com',
          style: greyTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: regular,
          ),
        ),
      ],
    );
  }

  Column _buildOptionList() {
    return Column(
      children: [
        const ProfileOption(
          imageAsset: 'ic_profile_active.png',
          title: 'Data Pribadi',
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        const ProfileOption(
          imageAsset: 'ic_setting.png',
          title: 'Pengaturan',
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        const ProfileOption(
          imageAsset: 'ic_info.png',
          title: 'Tentang Kami',
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        const ProfileOption(
          imageAsset: 'ic_logout.png',
          title: 'Keluar',
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final String imageAsset;
  // ignore: use_key_in_widget_constructors
  const ProfileOption({required this.title, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          //image icon
          Container(
            width: 32.0,
            height: 32.0,
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: kBlueBgColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(
              'assets/icons/$imageAsset',
              fit: BoxFit.cover,
            ),
          ),
          //title
          const SizedBox(width: 20),
          Text(
            title,
            style: greyTextStyle.copyWith(
              fontSize: 16.0,
              fontWeight: regular,
            ),
          )
        ],
      ),
    );
  }
}
