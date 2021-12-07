import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

import '../../../common/navigation.dart';
import '../../../data/model/user_model.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../widgets/profile_option.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                _buildProfilePicture(),
                const SizedBox(height: 20),
                _buildName(),
                const SizedBox(height: 40),
                _buildOptionList(context),
              ],
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
          'Profil',
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
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.firebaseFirestore
          .collection('users')
          .doc(Auth.auth.currentUser?.uid)
          .snapshots(),
      builder: (_, snapshot) {
        UserModel? user;
        if (snapshot.hasData) {
          user = UserModel.getDataUser(snapshot.data!);
        }

        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Text(
              user!.name,
              style: blackTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              user.email,
              style: greyTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: regular,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOptionList(BuildContext context) {
    return Column(
      children: [
        ProfileOption(
          imageAsset: 'ic_edit_profile.png',
          title: 'Edit Profil',
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        ProfileOption(
          imageAsset: 'ic_setting.png',
          title: 'Pengaturan',
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        ProfileOption(
          imageAsset: 'ic_info.png',
          title: 'Tentang Kami',
          onTap: () {},
        ),
        const SizedBox(height: 5),
        Divider(
          color: kWhiteBgColor,
          thickness: 2,
        ),
        const SizedBox(height: 5),
        ProfileOption(
          imageAsset: 'ic_logout.png',
          title: 'Keluar',
          onTap: () async {
            await Auth.auth.signOut();
            Navigation.intentReplacement(LoginPage.routeName);
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
