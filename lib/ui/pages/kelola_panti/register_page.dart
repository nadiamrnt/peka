import 'package:flutter/material.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/widgets/button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
              const SizedBox(height: 20.0),
              _buildName(),
              const SizedBox(height: 10.0),
              _buildPhoneNumber(),
              const SizedBox(height: 10.0),
              _buildDescription(),
              const SizedBox(height: 10.0),
              _buildFile(),
              const SizedBox(height: 10.0),
              _buildLocation(),
              const SizedBox(height: 10.0),
              //TODO:: Listview Kebutuhan panti
              Button(textButton: 'Perbarui', onTap: () {}),
              const SizedBox(height: 10.0),
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
              decoration: InputDecoration(
                  hintText: "Tulis deskripsi panti asuhan",
                  hintStyle: greyHintTextStyle,
                  border: InputBorder.none),
              style:
                  blackTextStyle.copyWith(fontWeight: regular, fontSize: 14.0)),
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
}
