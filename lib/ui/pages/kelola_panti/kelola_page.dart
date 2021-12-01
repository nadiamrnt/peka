import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';

class KelolaPage extends StatelessWidget {
  static const routeName = '/kelola-page';
  const KelolaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildListKelolaPanti(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'List Panti Asuhan',
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
        GestureDetector(
          //TODO:: Add Panti Asuhan button
          onTap: () {},
          child: Image.asset(
            'assets/icons/ic_dots.png',
            width: 32,
          ),
        ),
      ],
    );
  }

  Widget _buildListKelolaPanti() {
    return Flexible(
      child: ListView(
        children: [
          GestureDetector(
            child: Container(
              height: 184,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kWhiteBgColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 104,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/img_house.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Panti Asuhan Barokah',
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                                height: 1.75,
                              ),
                            ),
                            const SizedBox(height: 6),
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
                                  style: greyTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: light,
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
                        Container(
                          width: 76,
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: kPinkBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Beras',
                            textAlign: TextAlign.center,
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        Container(
                          width: 76,
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: kBlueBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Deterjen',
                            textAlign: TextAlign.center,
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                        Container(
                          width: 76,
                          height: 24,
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: kPinkBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Pakaian',
                            textAlign: TextAlign.center,
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 190,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: kWhiteBgColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 104,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/img_house.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Panti Asuhan Al-Khaer Selatan',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                              height: 1.75,
                            ),
                          ),
                          const SizedBox(height: 6),
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
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: light,
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
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kPinkBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Beras',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kBlueBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Deterjen',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kPinkBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Pakaian',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 190,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: kWhiteBgColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 104,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/img_house.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Panti Asuhan Sukses Bersama',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                              height: 1.75,
                            ),
                          ),
                          const SizedBox(height: 6),
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
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: light,
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
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kPinkBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Beras',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kBlueBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Deterjen',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kPinkBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Pakaian',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 190,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: kWhiteBgColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 104,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/img_house.png'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Panti Asuhan Barokah',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                              height: 1.75,
                            ),
                          ),
                          const SizedBox(height: 6),
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
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: light,
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
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kPinkBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Beras',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kBlueBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Deterjen',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 24,
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: kPinkBgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Pakaian',
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
