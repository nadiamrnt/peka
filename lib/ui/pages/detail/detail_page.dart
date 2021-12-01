import 'package:flutter/material.dart';
import 'package:peka/Utils/category_helper.dart';
import 'package:peka/common/styles.dart';

import '../../widgets/button.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail-page';
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildContent(),
              const SizedBox(height: 15),
              _buildCategory(),
              const SizedBox(height: 30),
              _buildLocation(),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Button(textButton: 'Navigasi', onTap: () {}),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                //TODO:: navigation back
                onTap: () {},
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Text(
                'Detail',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                //TODO:: Like button
                onTap: () {},
                child: Image.asset(
                  'assets/icons/ic_dots.png',
                  width: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // TODO:: CachedNetworkImage
          Container(
            height: 328,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/img_house.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Panti Asuhan Al-Khaer',
            style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Image.asset(
                'assets/icons/ic_location.png',
                width: 11,
                height: 14,
              ),
              const SizedBox(width: 7),
              Text(
                'Makassar',
                style:
                    greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'American classic house, this house has always been a target for property companies because of its ancient style but very attractive',
            style: greyTextStyle.copyWith(height: 1.75, fontWeight: regular),
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
            'Kebutuhan',
            style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 75,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 24),
            children: CategoryHelper.categoryFromLocal.map((item) {
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
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lokasi',
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: kWhiteBgColor,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Makassar, Biringkanaya, 90242, Jl. Jend. Sudirman No. 53',
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
