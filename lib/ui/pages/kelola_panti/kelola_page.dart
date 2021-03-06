import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/ui/pages/kelola_panti/detail_kelola_page.dart';
import 'package:peka/ui/pages/kelola_panti/intro_kelola_page.dart';
import 'package:peka/ui/pages/kelola_panti/register_and_update_page.dart';

import '../../../services/firebase/firestore/firestore.dart';

class KelolaPage extends StatelessWidget {
  static const routeName = '/kelola-page';

  const KelolaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: Firestore.firebaseFirestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('kelola_panti')
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: LottieBuilder.asset(
                'assets/raw/loading.json',
                width: 200,
              ));
            }

            List<PantiAsuhanModel> pantiAsuhan = [];
            List<PantiAsuhanModel> approvedPantiAsuhan = [];

            for (var doc in snapshot.data!.docs) {
              pantiAsuhan.add(PantiAsuhanModel.fromDatabase(doc));
            }

            for (var item in pantiAsuhan) {
              if (item.approved == true) {
                approvedPantiAsuhan.add(item);
              }
            }

            if (approvedPantiAsuhan.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildListKelolaPanti(approvedPantiAsuhan, context),
                  ],
                ),
              );
            } else {
              return const IntroKelolaPage();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Kelola Panti Asuhan',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigation.intent(RegisterAndUpdatePage.routeName);
          },
          child: Image.asset(
            'assets/icons/ic_kelola_plus.png',
            width: 32,
          ),
        ),
      ],
    );
  }

  Widget _buildListKelolaPanti(
      List<PantiAsuhanModel> listDataPanti, BuildContext context) {
    return Flexible(
      child: ListView(
        children: listDataPanti.map((pantiAsuhan) {
          var splitString = pantiAsuhan.address.split(', ');
          String location = "${splitString[4]}, ${splitString[5]}";
          int? _kebutuhanLenght;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailKelolaPage(
                    pantiAsuhan: pantiAsuhan,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kWhiteBgColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 104,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              pantiAsuhan.imgUrl,
                              fit: BoxFit.cover,
                            ),
                          )),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pantiAsuhan.name,
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                                height: 1.75,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/icons/ic_location.png',
                                  width: 11,
                                  height: 14,
                                ),
                                const SizedBox(width: 7),
                                Flexible(
                                  child: Text(
                                    location,
                                    style: greyTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: light,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Row(
                          children: pantiAsuhan.kebutuhan
                              .map((kebutuhan) {
                                _kebutuhanLenght = pantiAsuhan.kebutuhan.length;
                                return Container(
                                  width: 76,
                                  height: 24,
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(
                                    color: pantiAsuhan.kebutuhan
                                            .indexOf(kebutuhan)
                                            .isOdd
                                        ? kPinkBgColor
                                        : kBlueBgColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    kebutuhan.name,
                                    textAlign: TextAlign.center,
                                    style: greyTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: regular,
                                    ),
                                  ),
                                );
                              })
                              .toList()
                              .getRange(
                                  0,
                                  (_kebutuhanLenght! > 3)
                                      ? 3
                                      : _kebutuhanLenght!)
                              .toList(),
                        ),
                        const SizedBox(width: 4),
                        _kebutuhanLenght! > 3
                            ? Flexible(
                                child: Text(
                                  '+' + (_kebutuhanLenght! - 3).toString(),
                                  style: greyTextStyle.copyWith(
                                    fontWeight: regular,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
