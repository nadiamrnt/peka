import 'package:flutter/material.dart';
import 'package:peka/data/model/donatur_model.dart';

class DetailDonatur extends StatefulWidget {
  static const routeName = '/detail-donatur';
  const DetailDonatur({Key? key}) : super(key: key);

  @override
  _DetailDonaturState createState() => _DetailDonaturState();
}

class _DetailDonaturState extends State<DetailDonatur> {
  @override
  Widget build(BuildContext context) {
    final _donatur = ModalRoute.of(context)?.settings.arguments as DonaturModel;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(_donatur),
              const SizedBox(height: 30),
              _buildProfile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(DonaturModel donatur) {
    return Padding(
      padding:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
      child: Column(
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
                  'Detail',
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
            height: 328,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pantiAsuhan.imgUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
