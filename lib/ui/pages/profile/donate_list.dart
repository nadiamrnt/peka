import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/donatur_model.dart';

import '../../../common/navigation.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';

class DonateList extends StatefulWidget {
  static const routeName = '/Donate-list-page';

  const DonateList({Key? key}) : super(key: key);

  @override
  State<DonateList> createState() => _DonateListState();
}

class _DonateListState extends State<DonateList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              Expanded(child: _buildDonateList()),
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
                  'Daftar Donasi',
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

  Widget _buildDonateList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.firebaseFirestore
          .collection('users')
          .doc(Auth.firebaseAuth.currentUser!.uid)
          .collection('daftar_donasi')
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
          List<DonaturModel> _donateList = snapshot.data!.docs
              .map((data) => DonaturModel.fromDatabase(data))
              .toList();

          return snapshot.hasData
              ? ListView(
                  children: _donateList.map((donasi) {
                  int? _donasiKebutuhanLenght;
                  return Container(
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
                                  donasi.imgDonation,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Kurir',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: medium,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          donasi.courier,
                                          textAlign: TextAlign.end,
                                          style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: light,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'No resi',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: medium,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          donasi.noReceipt,
                                          textAlign: TextAlign.end,
                                          style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: light,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tanggal',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: medium,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          '${donasi.date.toDate().day}-${donasi.date.toDate().month}-${donasi.date.toDate().year}',
                                          textAlign: TextAlign.end,
                                          style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: light,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                children: donasi.donation
                                    .map((kebutuhan) {
                                      _donasiKebutuhanLenght =
                                          donasi.donation.length;
                                      return Container(
                                        width: 76,
                                        height: 24,
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.only(top: 2),
                                        decoration: BoxDecoration(
                                          color: donasi.donation
                                                  .indexOf(kebutuhan)
                                                  .isOdd
                                              ? kPinkBgColor
                                              : kBlueBgColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        (_donasiKebutuhanLenght! > 3)
                                            ? 3
                                            : _donasiKebutuhanLenght!)
                                    .toList(),
                              ),
                              const SizedBox(width: 4),
                              _donasiKebutuhanLenght! > 3
                                  ? Flexible(
                                      child: Text(
                                        '+' +
                                            (_donasiKebutuhanLenght! - 3)
                                                .toString(),
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
                  );
                }).toList())
              : LottieBuilder.asset(
                  'assets/raw/loading.json',
                  width: 200,
                );
        } else {
          return Wrap();
        }
      },
    );
  }
}
