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
import '../detail/detail_page.dart';
import 'category_page.dart';
import 'filter_list_dialog.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final _pantiAsuhanCollection =
      Firestore.firebaseFirestore.collection('panti_asuhan');
  final _userCollection = Firestore.firebaseFirestore
      .collection('users')
      .doc(Auth.firebaseAuth.currentUser!.uid);

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
    return FutureBuilder<UserModel?>(
      future: getDataUser(),
      builder: (_, snapshot) {
        UserModel? userData;
        if (snapshot.hasData) {
          userData = snapshot.data;
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
                      userData != null ? 'Halo,\n${userData.name}' : '',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  userData != null
                      ? Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: userData.imageProfile.isNotEmpty
                                  ? Image.network(userData.imageProfile).image
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
                    return const FilterListDialog();
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
          child: FutureBuilder<List<PantiAsuhanModel>>(
            future: getDataPantiAsuhan(),
            builder: (_, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      padding: const EdgeInsets.only(left: 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data == null) {
                          return Center(
                            child: LottieBuilder.asset(
                              'assets/raw/loading.json',
                              width: 200,
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigation.intentWithData(
                                DetailPage.routeName, snapshot.data![index]);
                          },
                          child: _itemPantiAsuhan(snapshot.data![index]),
                        );
                      },
                    )
                  : Center(
                      child: LottieBuilder.asset(
                        'assets/raw/loading.json',
                        width: 200,
                      ),
                    );
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

  Future<List<PantiAsuhanModel>> getDataPantiAsuhan() async {
    List<PantiAsuhanModel> pantiAsuhan = [];
    List<PantiAsuhanModel> approvedPantiAsuhan = [];
    await _pantiAsuhanCollection.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        pantiAsuhan.add(PantiAsuhanModel.fromDatabase(doc));
      }
    });

    for (var item in pantiAsuhan) {
      if (item.approved == true) {
        approvedPantiAsuhan.add(item);
      }
    }

    return approvedPantiAsuhan;
  }

  Future<UserModel?> getDataUser() async {
    UserModel? userModel;
    await _userCollection.get().then((DocumentSnapshot documentSnapshot) {
      userModel = UserModel.getDataUser(documentSnapshot);
    });
    return userModel;
  }
}
