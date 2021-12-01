import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/kelola_panti/kelola_page.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/utils/category_helper.dart';

import '../../../common/navigation.dart';
import '../../../data/model/kebutuhan_panti_asuhan.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register-page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<KebutuhanPantiAsuhan> _listCategory = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 30.0),
              _buildAddImage(),
              const SizedBox(height: 24.0),
              _buildName(),
              const SizedBox(height: 16.0),
              _buildPhoneNumber(),
              const SizedBox(height: 16.0),
              _buildDescription(),
              const SizedBox(height: 16.0),
              _buildFile(),
              const SizedBox(height: 16.0),
              _buildLocation(),
              const SizedBox(height: 20.0),
              _buildListCategory(),
              const SizedBox(height: 40.0),
              Button(
                textButton: 'Perbarui',
                onTap: () {
                  Navigation.intent(KelolaPage.routeName);
                },
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      )),
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
                //TODO:: navigation back
                onTap: () {},
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Expanded(
                child: Text(
                  'Registrasi Panti Asuhan',
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

  Widget _buildAddImage() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0XFFF0F0F0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 70.0,
                height: 70.0,
                child: Image.asset('assets/icons/ic_add_image.png'),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Tambah foto panti asuhan',
                style: greyTextStyle.copyWith(
                  fontSize: 12.0,
                  fontWeight: regular,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nama",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        //TEXTFIELD NAMA PANTI ASUHAN
        Container(
          height: 45.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: kGreyBgColor,
              borderRadius: BorderRadius.circular(defaultRadiusTextField)),
          child: TextField(
              decoration: InputDecoration(
                  hintText: "Tulis nama panti asuhan",
                  hintStyle: greyHintTextStyle,
                  border: InputBorder.none),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nomor Telepon",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        //TEXTFIELD NOMOR TELEPON
        Container(
          height: 45.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: kGreyBgColor,
              borderRadius: BorderRadius.circular(defaultRadiusTextField)),
          child: TextField(
              decoration: InputDecoration(
                  hintText: "Tulis nomor telepon panti asuhan",
                  hintStyle: greyHintTextStyle,
                  border: InputBorder.none),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Deskripsi",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        //TEXTFIELD DESKRIPSI
        Container(
          height: 149.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: kGreyBgColor,
              borderRadius: BorderRadius.circular(defaultRadiusTextField)),
          child: TextField(
            maxLines: 6,
            decoration: InputDecoration(
                hintText: "Tulis deskripsi panti asuhan",
                hintStyle: greyHintTextStyle,
                border: InputBorder.none),
            style: blackTextStyle.copyWith(
              fontWeight: regular,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFile() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Surat Keterangan",
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
          ),
          const SizedBox(height: 5.0),
          //BUTTON UNTUK MENAMBAHKAN FILE
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 45.0,
              width: 185,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(defaultRadiusTextField),
                border: Border.all(color: kPrimaryColor),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/ic_upload.png',
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Tambahkan file',
                    style: purpleTextStyle.copyWith(
                        fontSize: 14, fontWeight: regular),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tandai Lokasi",
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
          ),
          const SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: kGreyBgColor,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 38.0,
                      height: 38.0,
                      child: Image.asset('assets/icons/ic_add_location.png'),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Tandai Lokasi',
                      style: greyTextStyle.copyWith(
                        fontSize: 12.0,
                        fontWeight: regular,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kebutuhan Panti',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: regular,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: CategoryHelper.categoryFromLocal.map((kebutuhan) {
              String name = kebutuhan['name'];
              String image = kebutuhan['image'];
              var dataPantiAsuhan =
                  KebutuhanPantiAsuhan(name: name, image: image);
              return _itemListKebutuhan(dataPantiAsuhan);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _itemListKebutuhan(KebutuhanPantiAsuhan dataPantiAsuhan) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_listCategory.contains(dataPantiAsuhan)) {
            _listCategory.remove(dataPantiAsuhan);
          } else {
            _listCategory.add(dataPantiAsuhan);
          }
        });
      },
      child: Container(
        width: 80,
        height: 100,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: kWhiteBgColor,
          borderRadius: const BorderRadius.all(Radius.circular(22)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _listCategory.contains(dataPantiAsuhan)
                    ? Image.asset(
                        'assets/icons/ic_checklist.png',
                        width: 27,
                        height: 25,
                      )
                    : const SizedBox(
                        height: 25,
                      ),
              ],
            ),
            const SizedBox(height: 3),
            Column(
              children: [
                Image.asset(dataPantiAsuhan.image, height: 30),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  dataPantiAsuhan.name,
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
