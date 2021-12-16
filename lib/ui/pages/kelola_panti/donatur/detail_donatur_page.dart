import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/donatur_model.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/ui/widgets/toast.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailDonatur extends StatefulWidget {
  static const routeName = '/detail-donatur';
  const DetailDonatur({Key? key}) : super(key: key);

  @override
  _DetailDonaturState createState() => _DetailDonaturState();
}

class _DetailDonaturState extends State<DetailDonatur> {
  final TextEditingController _ucapanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _donatur = ModalRoute.of(context)?.settings.arguments as DonaturModel;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                top: 30,
                bottom: defaultMargin),
            child: Column(
              children: [
                _buildHeader(_donatur),
                const SizedBox(height: 30),
                _buildProfile(_donatur),
                const SizedBox(height: 24),
                _buildKurir(_donatur),
                const SizedBox(height: 24),
                _buildContent(_donatur),
                const SizedBox(height: 24),
                Button(
                    textButton: 'Kirim Ucapan',
                    onTap: () {
                      _modalBottomSheetMenu(context, _donatur);
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

  Widget _buildProfile(DonaturModel donatur) {
    var date = donatur.date.toDate();
    timeago.setLocaleMessages('id', timeago.IdMessages());
    var timeAgo = timeago.format(date, locale: 'id');

    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: ClipOval(
              child: Image.network(donatur.ownerImage, fit: BoxFit.cover)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(donatur.ownerName,
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
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            Row(
              children: [
                Image.asset(
                  'assets/icons/ic_receipt.png',
                  width: 24,
                ),
                const SizedBox(width: 10),
                Text(donatur.noReceipt,
                    style: greyTextStyle.copyWith(
                        fontWeight: regular, fontSize: 14)),
              ],
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

  void _modalBottomSheetMenu(BuildContext context, DonaturModel donatur) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (builder) {
        return Container(
          height: 150,
          padding: const EdgeInsets.only(
            top: 24,
            left: 70,
            right: 70,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: [
              CustomTextFormField(
                  hintText: "Tulis ucapan untuk donatur",
                  errorText: "Tulis ucapan untuk donatur",
                  controller: _ucapanController),
              const SizedBox(height: 16),
              Button(
                textButton: 'Kirim Ucapan',
                onTap: () {
                  Navigation.back();
                  const Toast(
                    toastTitle: 'Ucapan Terkirim!',
                  ).successToast().show(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
