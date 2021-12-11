import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/kebutuhan_model.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/utils/category_helper.dart';

class SendDonationPage extends StatefulWidget {
  const SendDonationPage({Key? key}) : super(key: key);
  static const routeName = '/send-donation-page';

  @override
  State<SendDonationPage> createState() => _SendDonationPageState();
}

class _SendDonationPageState extends State<SendDonationPage> {
  final List<KebutuhanModel> _listKebutuhan = [];
  final List<String> kurir = ['JNE', 'JNT', 'SiCepat', 'Pos Indonesia', 'TIKI'];
  var value;

  // controller text
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 30.0),
                _buildAddImage(),
                const SizedBox(height: 24.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildKurir(),
                      const SizedBox(height: 16.0),
                      _buildPhoneNumber(),
                      const SizedBox(height: 16.0),
                      _buildNote(),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildListCategory(),
                const SizedBox(height: 40.0),
                Button(textButton: 'Kirim', onTap: () {}),
                const SizedBox(height: 30.0),
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

  Widget _buildAddImage() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 200,
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
                'Tambah foto bukti pengiriman',
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

  //TODO:: DROP DOWN WIDGET
  Widget _buildKurir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kurir",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            color: kGreyBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 15),
          child: DropdownSearch(
            showAsSuffixIcons: true,
            mode: Mode.MENU,
            items: kurir,
            dropdownSearchDecoration: InputDecoration(
                constraints: const BoxConstraints(maxHeight: 45),
                border: InputBorder.none,
                hintText: 'Pilih kurir',
                hintStyle: greyHintTextStyle.copyWith(fontSize: 14)),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nomor Resi",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        CustomTextFormField(
          hintText: 'Tulis nomor resi pengiriman',
          errorText: 'Masukkan nomor resi pengiriman',
          controller: _phoneController,
        ),
      ],
    );
  }

  Widget _buildNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catatan",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        CustomTextFormField(
          hintText: 'Tulis catatan untuk panti asuhan',
          errorText: 'Masukkan catatan untuk panti asuhan',
          controller: _descController,
        )
      ],
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
              var dataPantiAsuhan = KebutuhanModel(name: name, image: image);
              return _itemListKebutuhan(dataPantiAsuhan);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _itemListKebutuhan(KebutuhanModel dataPantiAsuhan) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_listKebutuhan.contains(dataPantiAsuhan)) {
            _listKebutuhan.remove(dataPantiAsuhan);
          } else {
            _listKebutuhan.add(dataPantiAsuhan);
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
                _listKebutuhan.contains(dataPantiAsuhan)
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
