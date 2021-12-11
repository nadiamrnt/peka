import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/utils/category_helper.dart';

class DetailKelolaPage extends StatelessWidget {
  static const routeName = '/detail-kelola-page';

  const DetailKelolaPage({Key? key}) : super(key: key);

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
              _buildImage(),
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
                  'Kirim Donasi',
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

  Widget _buildImage() {
    return Stack(
      children: [
        SizedBox(
          height: 230,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              'assets/images/img_house.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 230,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Panti Asuhan Barokah',
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
                    Text(
                      'Indonesia, Makassar',
                      style: whiteTextStyle.copyWith(
                          fontSize: 14, fontWeight: light),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
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
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildCardDonatur();
        },
      ),
    );
  }

  Widget _buildCardDonatur() {
    return Column(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Image.asset(
                        'assets/images/img_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Muhammad Ridhoi',
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
                            '19 Desember 2021',
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
              _buildCategory(),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCategory() {
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
            children: CategoryHelper.categoryFromLocal.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                    const SizedBox(height: 8),
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
}
