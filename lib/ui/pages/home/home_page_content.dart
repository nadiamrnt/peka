import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/data/model/user_model.dart';
import 'package:peka/ui/pages/home/search_page.dart';
import 'package:peka/utils/category_helper.dart';

import '../../../common/navigation.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../widgets/custom_dialog_box.dart';
import '../detail/detail_page.dart';
import 'category/category_page.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildSearch(context),
              const SizedBox(height: 24),
              _buildCategory(),
              const SizedBox(height: 24),
              _buildListPantiAsuhan(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.firebaseFirestore
          .collection('users')
          .doc(Auth.auth.currentUser?.uid)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          user = UserModel.getDataUser(data!);
        }

        return Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: defaultMargin,
            right: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      user != null ? 'Halo,\n${user?.name}' : '',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  user != null
                      ? Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: user!.imageProfile.isNotEmpty
                                  ? Image.network(user!.imageProfile).image
                                  : const AssetImage(
                                      'assets/icons/ic_add_profile.png',
                                    ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Mau donasi apa hari ini?',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: light,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearch(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45,
              child: GestureDetector(
                onTap: () {
                  Navigation.intent(SearchPage.routeName);
                },
                child: TextField(
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                  textInputAction: TextInputAction.none,
                  textAlign: TextAlign.left,
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Cari Panti Asuhan',
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: regular,
                    ),
                    contentPadding: const EdgeInsets.only(right: 8, left: 12),
                    filled: true,
                    fillColor: kWhiteBgColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 14.0,
                        right: 18,
                      ),
                      child: Image.asset(
                        'assets/icons/ic_search.png',
                        width: 24,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 24,
                      minWidth: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CustomDialogBox();
                  });
            },
            child: Container(
              height: 45,
              width: 47,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/icons/ic_filter.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            'Kategori',
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 75,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 24),
            children: CategoryHelper.categoryFromLocal.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigation.intentWithData(CategoryPage.routeName, item);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CategoryHelper.categoryFromLocal
                                  .indexOf(item)
                                  .isEven
                              ? kBlueBgColor
                              : kPinkBgColor,
                        ),
                        child: Image.asset(
                          item['image'],
                          width: 30,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['name'],
                        style: greyTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildListPantiAsuhan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: defaultMargin),
          child: Text(
            'Rekomendasi',
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 330,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: Firestore.firebaseFirestore
                .collection('panti_asuhan')
                .snapshots(),
            builder: (_, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      padding: const EdgeInsets.only(left: 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        PantiAsuhanModel pantiAsuhan =
                            PantiAsuhanModel.fromDatabase(data);
                        if (snapshot.data == null) {
                          return Center(
                            child:
                                LottieBuilder.asset('assets/raw/loading.json'),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigation.intentWithData(
                                DetailPage.routeName, pantiAsuhan);
                          },
                          child: _itemPantiAsuhan(pantiAsuhan),
                        );
                      },
                    )
                  : Center(
                      child: LottieBuilder.asset('assets/raw/loading.json'));
            },
          ),
        ),
      ],
    );
  }

  Widget _itemPantiAsuhan(PantiAsuhanModel pantiAsuhan) {
    return Container(
      height: 324,
      width: 235,
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: kWhiteBgColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            height: 224,
            width: 215,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pantiAsuhan.imgUrl),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pantiAsuhan.name,
                  style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_location.png',
                      height: 14,
                      width: 11,
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        pantiAsuhan.address.split(', ')[4],
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: light,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
