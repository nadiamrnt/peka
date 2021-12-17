import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/donatur_model.dart';
import 'package:peka/data/model/user_model.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../widgets/dialog_kirim_ucapan.dart';

class DetailDonatur extends StatefulWidget {
  static const routeName = '/detail-donatur';

  const DetailDonatur({Key? key}) : super(key: key);

  @override
  _DetailDonaturState createState() => _DetailDonaturState();
}

class _DetailDonaturState extends State<DetailDonatur> {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    DonaturModel _dataDonasi = data['data_donasi'];
    UserModel _userData = UserModel.getDataUser(data['data_user']);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: defaultMargin, right: defaultMargin, top: 30, bottom: 30),
            child: Column(
              children: [
                _buildHeader(_dataDonasi),
                const SizedBox(height: 30),
                _buildProfile(_dataDonasi, _userData),
                const SizedBox(height: 24),
                _buildKurir(_dataDonasi),
                const SizedBox(height: 24),
                _buildContent(_dataDonasi),
                const SizedBox(height: 40),
                Button(
                    textButton: 'Kirim Ucapan',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const DialogReview(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(DonaturModel donatur) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigation.back(),
              child: Image.asset(
                'assets/icons/ic_back.png',
                width: 32,
              ),
            ),
            Expanded(
              child: Text(
                'Detail Donatur',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(donatur.imgDonation),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(DonaturModel donatur, UserModel userModel) {
    var date = donatur.date.toDate();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    var timeAgo = timeago.format(date, locale: 'id');

    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: ClipOval(
              child: Image.network(userModel.imageProfile, fit: BoxFit.cover)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userModel.name,
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium)),
            const SizedBox(height: 7),
            Row(
              children: [
                Image.asset(
                  'assets/icons/ic_calendar.png',
                  width: 14,
                ),
                const SizedBox(width: 5),
                Text(timeAgo,
                    style: greyTextStyle.copyWith(
                        fontSize: 13, fontWeight: light)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKurir(DonaturModel donatur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pengiriman',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium)),
        const SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/ic_delivery.png',
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(donatur.courier,
                      style: greyTextStyle.copyWith(
                          fontWeight: regular, fontSize: 14)),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/ic_receipt.png',
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(donatur.noReceipt,
                        style: greyTextStyle.copyWith(
                            fontWeight: regular, fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildContent(DonaturModel donatur) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catatan',
          style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Text(
          donatur.note,
          style: greyTextStyle.copyWith(height: 1.75, fontWeight: regular),
        ),
        const SizedBox(height: 24),
        Text(
          'Berdonasi',
          style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 75,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: donatur.donation.map((item) {
              return Padding(
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
                        color: donatur.donation.indexOf(item).isEven
                            ? kBlueBgColor
                            : kPinkBgColor,
                      ),
                      child: Image.asset(
                        item.image,
                        width: 30,
                      ),
                    ),
                    const SizedBox(height: 12),
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
            }).toList(),
          ),
        ),
      ],
    );
  }
}
