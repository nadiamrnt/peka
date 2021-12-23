import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);
  static const routeName = '/about-page';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildContent(),
                const SizedBox(height: 30),
                _buildContactUs(),
                const SizedBox(height: 30),
              ],
            ),
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
                  'Tentang Kami',
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

  Widget _buildContent() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: blackTextStyle.copyWith(fontSize: 16),
            children: [
              TextSpan(
                text: 'PEKA',
                style: TextStyle(fontWeight: semiBold),
              ),
              TextSpan(
                text:
                    ' adalah aplikasi yang ditujukan untuk menerima dan memberikan bantuan sosial berupa barang dan lainnya yang difokuskan untuk membantu panti asuhan sesuai dengan kebutuhannya.',
                style: TextStyle(fontWeight: regular),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: blackTextStyle.copyWith(fontSize: 16),
            children: [
              TextSpan(
                text: 'PEKA',
                style: TextStyle(fontWeight: semiBold),
              ),
              TextSpan(
                text:
                    ' memiliki tujuan utama yaitu dapat mewadahi informasi kebutuhan panti asuhan agar para donatur dapat menyalurkan donasi secara tepat.',
                style: TextStyle(fontWeight: regular),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: blackTextStyle.copyWith(fontSize: 16),
            children: [
              TextSpan(
                text:
                    'Dengan adanya pemanfaatan dan penerapan ilmu serta niat yang ikhlas sehingga menghasilkan suatu aplikasi yang disebut dengan ',
                style: TextStyle(fontWeight: regular),
              ),
              TextSpan(
                text: 'PEKA',
                style: TextStyle(fontWeight: semiBold),
              ),
              TextSpan(
                text:
                    ', wadah penyaluran bantuan sosial yang dapat membantu masyarakat serta mendorong masyarakat untuk memiliki kepedulian yang lebih besar dalam membantu sesama.',
                style: TextStyle(fontWeight: regular),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hubungi Kami',
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/nadia.png',
                    width: 75,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nadia Miranti',
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'nadiamrnt@gmail.com',
                    style:
                        greyTextStyle.copyWith(fontSize: 14, fontWeight: light),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 63),
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/ridhoi.png',
                    width: 75,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Muhammad Ridhoi',
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: medium),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ridhoim18d@student.unhas.ac.id',
                    style:
                        greyTextStyle.copyWith(fontSize: 14, fontWeight: light),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
