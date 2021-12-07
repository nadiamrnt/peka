import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/data/model/user_model.dart';
import 'package:peka/ui/pages/detail/detail_page.dart';
import 'package:peka/utils/category_helper.dart';

import '../../../common/navigation.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
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
              _buildSearch(),
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
                      'Halo,\n${user?.name}',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/img_profile.png',
                        ),
                      ),
                    ),
                  ),
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

  Widget _buildSearch() {
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
              child: TextField(
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
                textAlign: TextAlign.left,
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
          const SizedBox(width: 6),
          Container(
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
                  // TODO: Bawah data item ke CategoryPage
                  Navigation.intent(CategoryPage.routeName);
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
              stream:
                  Firestore.firebaseFirestore.collection('users').snapshots(),
              builder: (_, users) {
                return users.hasData
                    ? ListView.builder(
                        padding: const EdgeInsets.only(left: 24),
                        scrollDirection: Axis.horizontal,
                        itemCount: users.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot userData = users.data!.docs[index];
                          return StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>>(
                            stream: Firestore.firebaseFirestore
                                .collection('users')
                                .doc(userData.id)
                                .collection('kelola_panti')
                                .snapshots(),
                            builder: (_, user) {
                              if (user.data == null) {
                                return const Center(
                                  // TODO:: ganti loading
                                  child: CircularProgressIndicator(),
                                );
                              }

                              // TODO:: Need revisi
                              if (user.data!.docs.isNotEmpty) {
                                int index = 1;
                                user.data?.docs.map((item) {
                                  index = user.data!.docs.indexOf(item);
                                });

                                DocumentSnapshot? itemDataPanti =
                                    user.data?.docs[index];
                                PantiAsuhanModel pantiAsuhan =
                                    PantiAsuhanModel.fromDatabase(
                                        itemDataPanti);

                                return itemDataPanti != null
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigation.intentWithData(
                                              DetailPage.routeName,
                                              pantiAsuhan);
                                        },
                                        child: Container(
                                          height: 324,
                                          width: 235,
                                          margin:
                                              const EdgeInsets.only(right: 24),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: kWhiteBgColor,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 224,
                                                width: 215,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        pantiAsuhan.imgUrl),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      pantiAsuhan.name,
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  medium,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/ic_location.png',
                                                          height: 14,
                                                          width: 11,
                                                        ),
                                                        const SizedBox(
                                                            width: 7),
                                                        Text(
                                                          pantiAsuhan.address
                                                              .split(', ')[4],
                                                          style: greyTextStyle
                                                              .copyWith(
                                                            fontSize: 14,
                                                            fontWeight: light,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const CircularProgressIndicator();
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        },
                      )
                    : const CircularProgressIndicator();
              },
            )),
      ],
    );
  }
}
