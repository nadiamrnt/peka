import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/donatur_model.dart';
import 'package:peka/ui/pages/kelola_panti/donatur/detail_donatur_page.dart';
import 'package:peka/ui/pages/kelola_panti/register_and_update_page.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/model/panti_asuhan_model.dart';
import '../../../services/firebase/firestore/firestore.dart';

class DetailKelolaPage extends StatelessWidget {
  static const routeName = '/detail-kelola-page';
  final PantiAsuhanModel? pantiAsuhan;

  const DetailKelolaPage({Key? key, this.pantiAsuhan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30.0),
              _buildImage(context),
              const SizedBox(height: 24.0),
              Text('Daftar Donatur',
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium)),
              const SizedBox(height: 16),
              _buildListDonatur(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigation.back();
                },
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Expanded(
                child: Text(
                  'Detail Kelola Panti Asuhan',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              pantiAsuhan!.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kBlackColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pantiAsuhan!.name,
                  style: whiteTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/ic_location.png',
                      width: 10,
                      height: 14,
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        '${pantiAsuhan!.address.split(', ')[4]}, ${pantiAsuhan!.address.split(', ')[5]}',
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: light),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RegisterAndUpdatePage(pantiAsuhan: pantiAsuhan),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kGreyColor,
                    minimumSize: const Size(55, 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: whiteTextStyle.copyWith(
                        fontSize: 12, fontWeight: medium),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListDonatur() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: Firestore.firebaseFirestore
          .collection('panti_asuhan')
          .doc(pantiAsuhan!.pantiAsuhanId)
          .collection('daftar_donatur')
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return Center(
              child: LottieBuilder.asset(
            'assets/raw/loading.json',
            width: 200,
          ));
        }

        if (snapshot.data!.docs.isNotEmpty) {
          var _listDonatur = snapshot.data!.docs;
          return Expanded(
              child: ListView(
            children: _listDonatur.map((dataDonatur) {
              DonaturModel donaturModel =
                  DonaturModel.fromDatabase(dataDonatur);
              return _buildCardDonatur(donaturModel);
            }).toList(),
          ));
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  'assets/images/no_data.png',
                  width: 180,
                ),
                const SizedBox(height: 6),
                Text(
                  'Opss Tidak ada donatur nihh',
                  style: greyTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildCardDonatur(DonaturModel donatur) {
    var date = donatur.date.toDate();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    var timeAgo = timeago.format(date, locale: 'id');

    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.firebaseFirestore
            .collection('users')
            .doc(donatur.userId)
            .snapshots(),
        builder: (_, userData) {
          if (!userData.hasData) {
            return Wrap();
          }

          return GestureDetector(
            onTap: () {
              Navigation.intentWithData(DetailDonatur.routeName,
                  {'data_donasi': donatur, 'data_user': userData.data});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  height: 208,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kWhiteBgColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipOval(
                              child: Image.network(
                                userData.data?.get('img_profile'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.data!.get('name'),
                                style: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: medium),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/ic_calendar.png',
                                    width: 14,
                                    height: 14,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    timeAgo,
                                    style: greyTextStyle.copyWith(
                                        fontSize: 13, fontWeight: light),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildCategory(donatur),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }

  Widget _buildCategory(DonaturModel donatur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Berdonasi',
          style: greyTextStyle.copyWith(fontSize: 12, fontWeight: regular),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: donatur.donation.map(
              (item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: donatur.donation.indexOf(item).isEven
                              ? kBlueBgColor
                              : kPinkBgColor,
                        ),
                        child: Image.asset(
                          item.image,
                          width: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.name,
                        style: greyTextStyle.copyWith(
                          fontWeight: regular,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
