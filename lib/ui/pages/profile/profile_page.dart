import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/profile/edit_profile_page.dart';
import 'package:peka/ui/widgets/toast.dart';

import '../../../common/navigation.dart';
import '../../../data/model/user_model.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../widgets/profile_option.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: kGreyBgColor,
      progressIndicator: LottieBuilder.asset(
        'assets/raw/loading.json',
        width: 200,
      ),
      isLoading: _isLoading,
      child: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.firebaseFirestore
            .collection('users')
            .doc(Auth.firebaseAuth.currentUser?.uid)
            .snapshots(),
        builder: (_, snapshot) {
          UserModel? user;
          if (snapshot.hasData) {
            user = UserModel.getDataUser(snapshot.data!);
          }

          if (snapshot.data == null) {
            return Center(
              child: LottieBuilder.asset(
                'assets/raw/loading.json',
                width: 200,
              ),
            );
          }

          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildProfilePicture(user),
                      const SizedBox(height: 20),
                      _buildName(user),
                      const SizedBox(height: 40),
                      _buildOptionList(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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

  Widget _buildProfilePicture(UserModel? user) {
    return user != null
        ? SizedBox(
            width: 140,
            height: 140,
            child: ClipOval(
              child: SizedBox(
                width: 120.0,
                height: 120.0,
                child: user.imageProfile.isNotEmpty
                    ? Image.network(
                        user.imageProfile,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/icons/ic_add_profile.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _buildName(UserModel? user) {
    return Column(
      children: [
        Text(
          user != null ? user.name : '',
          style: blackTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: semiBold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          user != null ? user.email : '',
          style: greyTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: regular,
          ),
        ),
      ],
    );
  }

  Widget _buildOptionList(BuildContext context) {
    return Column(
      children: [
        ProfileOption(
          imageAsset: 'ic_edit_profile.png',
          title: 'Edit Profil',
          onTap: () {
            Navigation.intent(EditProfilePage.routeName);
          },
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
          onTap: () {
            Toast(toastTitle: 'sedang dalam pengembangan')
                .waitingToast()
                .show(context);
          },
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
          onTap: () {
            Toast(toastTitle: 'sedang dalam pengembangan')
                .waitingToast()
                .show(context);
          },
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
            await Auth.firebaseAuth.signOut();
            Navigation.intentReplacement(LoginPage.routeName);
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
