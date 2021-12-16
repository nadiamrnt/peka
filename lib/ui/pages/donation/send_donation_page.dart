import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:peka/common/navigation.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/donatur_model.dart';
import 'package:peka/data/model/kebutuhan_model.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/data/model/user_model.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/ui/widgets/toast.dart';
import 'package:peka/utils/category_helper.dart';

import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../../utils/firebase_storage_helper.dart';
import '../../../utils/image_picker_helper.dart';

class SendDonationPage extends StatefulWidget {
  static const routeName = '/send-donation-page';

  const SendDonationPage({Key? key, this.pantiAsuhan}) : super(key: key);

  final PantiAsuhanModel? pantiAsuhan;

  @override
  State<SendDonationPage> createState() => _SendDonationPageState();
}

class _SendDonationPageState extends State<SendDonationPage> {
  final List<KebutuhanModel> _listKebutuhan = [];
  UserModel? user;
  bool _isLoading = false;
  String? _courier;
  File? _image;

  // controller text
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noReceiptController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      progressIndicator: LottieBuilder.asset('assets/raw/loading.json'),
      child: SafeArea(
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
                        _buildCourier(),
                        const SizedBox(height: 16.0),
                        _buildReceiptNumber(),
                        const SizedBox(height: 16.0),
                        _buildNote(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildListCategory(),
                  const SizedBox(height: 40.0),
                  _buildSendButton(context),
                  const SizedBox(height: 30.0),
                ],
              ),
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
      onTap: _modalBottomSheetMenu,
      child: _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.file(
                _image!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
            )
          : Container(
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

  Widget _buildCourier() {
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
            items: CategoryHelper.listCourier,
            onChanged: (value) {
              _courier = value.toString();
            },
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

  Widget _buildReceiptNumber() {
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
          controller: _noReceiptController,
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
          controller: _noteController,
        )
      ],
    );
  }

  Widget _buildListCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donasi',
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

  Widget _buildSendButton(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.firebaseFirestore
          .collection('users')
          .doc(Auth.firebaseAuth.currentUser?.uid)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          user = UserModel.getDataUser(data!);
        }

        return Button(
          textButton: 'Kirim',
          onTap: _sendDonation,
        );
      },
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
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
              Button(
                textButton: 'Ambil Foto',
                onTap: () async {
                  await ImagePickerHelper.imgFromCamera().then((image) {
                    setState(() {
                      _image = image;
                    });
                  });
                  Navigation.back();
                },
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () async {
                  await ImagePickerHelper.imgFromGallery().then((image) {
                    setState(() {
                      _image = image;
                    });
                  });
                  Navigation.back();
                },
                child: Text(
                  'Pilih dari galeri',
                  style:
                      greyTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _sendDonation() async {
    setState(() => _isLoading = true);

    if (_image != null || _courier != null) {
      String _imgUrl = await FirebaseStorageHelper.uploadImageDonation(_image!);
      Timestamp _timeNow = Timestamp.now();

      DonaturModel _donatur = DonaturModel(
        ownerId: user!.userId,
        ownerName: user!.name,
        ownerImage: user!.imageProfile,
        donationId: '',
        courier: _courier!,
        note: _noteController.text,
        noReceipt: _noReceiptController.text,
        imgDonation: _imgUrl,
        date: _timeNow,
        donation: _listKebutuhan,
      );

      try {
        await Firestore.firebaseFirestore
            .collection('users')
            .doc(widget.pantiAsuhan!.ownerId)
            .collection('kelola_panti')
            .doc(widget.pantiAsuhan!.pantiAsuhanId)
            .collection('daftar_donatur')
            .add(_donatur.setDataMap())
            .then(
          (value) async {
            await Firestore.firebaseFirestore
                .collection('users')
                .doc(widget.pantiAsuhan!.ownerId)
                .collection('kelola_panti')
                .doc(widget.pantiAsuhan!.pantiAsuhanId)
                .collection('daftar_donatur')
                .doc(value.id)
                .update({'donation_id': value.id});

            DonaturModel _donaturWithId = DonaturModel(
              ownerId: user!.userId,
              ownerName: user!.name,
              ownerImage: user!.imageProfile,
              donationId: value.id,
              courier: _courier!,
              note: _noteController.text,
              noReceipt: _noReceiptController.text,
              imgDonation: _imgUrl,
              date: _timeNow,
              donation: _listKebutuhan,
            );

            await Firestore.firebaseFirestore
                .collection('users')
                .doc(Auth.firebaseAuth.currentUser!.uid)
                .collection('daftar_donasi')
                .doc(value.id)
                .set(_donaturWithId.setDataMap());

            await Firestore.firebaseFirestore
                .collection('panti_asuhan')
                .doc(widget.pantiAsuhan!.pantiAsuhanId)
                .collection('daftar_donatur')
                .doc(value.id)
                .set(_donaturWithId.setDataMap());
          },
        );
      } catch (e) {
        const Toast(toastTitle: 'Opss.. Sepertinya terjadi kesalahan')
            .failedToast()
            .show(context);
      }

      setState(() => _isLoading = false);
      Navigation.back();
    } else {
      const Toast(toastTitle: 'Mohon lengkapi data anda')
          .failedToast()
          .show(context);
      setState(() => _isLoading = false);
    }
  }
}
