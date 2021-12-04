import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/pages/maps/google_maps_page.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/utils/category_helper.dart';
import 'package:peka/utils/file_picker_helper.dart';

import '../../../common/navigation.dart';
import '../../../data/model/kebutuhan_model.dart';
import '../../../utils/image_picker_helper.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register-page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<KebutuhanModel> _listKebutuhan = [];
  String? _address;
  GeoPoint? _location;
  XFile? _image;
  PlatformFile? _file;

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
                textButton: 'Kirim',
                onTap: () {
                  print(_address);
                  print(_location);
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
      onTap: () {
        _modalBottomSheetMenu();
      },
      child: _image != null
          ? Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: Image.file(
                    File(_image!.path),
                    fit: BoxFit.fill,
                  ).image,
                ),
              ),
            )
          : Container(
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
            onTap: () async {
              var platformFile = await getFileAndUpload();
              setState(() {
                _file = platformFile;
              });
              print('path :: ${platformFile!.path!}');
              print('file :: ${platformFile.name}');
            },
            child: _file != null
                ? Container(
                    height: 45.0,
                    width: 185,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius:
                          BorderRadius.circular(defaultRadiusTextField),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: Text(
                      _file!.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: purpleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  )
                : Container(
                    height: 45.0,
                    width: 185,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius:
                          BorderRadius.circular(defaultRadiusTextField),
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
            onTap: () async {
              final getData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoogleMapsPage()));
              _address = getData['address'];
              setState(() {
                _location = getData['location'];
              });
            },
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: kGreyBgColor,
              ),
              child: _location != null
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(_location!.latitude, _location!.longitude),
                        zoom: 16.0,
                      ),
                      zoomControlsEnabled: false,
                      //MARKER MERAH
                      // markers: Marker(),
                      mapType: MapType.normal,
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 38.0,
                            height: 38.0,
                            child:
                                Image.asset('assets/icons/ic_add_location.png'),
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
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await ImagePickerHelper.imgFromCamera().then((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                      Navigation.back();
                    },
                    child: const Text('Pick from camera'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await ImagePickerHelper.imgFromGallery().then((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                      Navigation.back();
                    },
                    child: const Text('Pick from gallery'),
                  ),
                ],
              ));
        });
  }
}
