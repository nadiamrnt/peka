import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/services/firebase/auth/auth.dart';
import 'package:peka/services/firebase/firestore/firestore.dart';
import 'package:peka/ui/pages/maps/google_maps_page.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/utils/category_helper.dart';
import 'package:peka/utils/file_picker_helper.dart';

import '../../../common/navigation.dart';
import '../../../data/model/kebutuhan_model.dart';
import '../../../utils/image_picker_helper.dart';

class RegisterAndUpdatePage extends StatefulWidget {
  static const routeName = '/register-page';

  const RegisterAndUpdatePage({Key? key}) : super(key: key);

  @override
  State<RegisterAndUpdatePage> createState() => _RegisterAndUpdatePageState();
}

class _RegisterAndUpdatePageState extends State<RegisterAndUpdatePage> {
  final List<KebutuhanModel> _listKebutuhan = [];
  String? _address;
  GeoPoint? _location;
  XFile? _image;
  PlatformFile? _file;
  final Set<Marker> _markers = {};

  bool _isLoading = false;

  // controller text
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // isUpdate page
  bool _isUpdate = false;
  PantiAsuhanModel? _pantiAsuhan;
  String? _documentId;

  @override
  Widget build(BuildContext context) {
    _isUpdateData();

    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
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
                        _buildName(),
                        const SizedBox(height: 16.0),
                        _buildPhoneNumber(),
                        const SizedBox(height: 16.0),
                        _buildDescription(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _buildFile(),
                  const SizedBox(height: 16.0),
                  _buildLocation(),
                  const SizedBox(height: 20.0),
                  _buildListCategory(),
                  const SizedBox(height: 40.0),
                  Button(
                    textButton: 'Kirim',
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        if (_formKey.currentState!.validate()) {
                          if (_image != null) {
                            // Send Image
                            String _imagePath = _image!.path;
                            Reference ref = FirebaseStorage.instance
                                .ref()
                                .child('image_panti')
                                .child(_imagePath);
                            UploadTask task = ref.putFile(File(_image!.path));
                            TaskSnapshot snapShot = await task;
                            String _imgUrl =
                                await snapShot.ref.getDownloadURL();

                            // Send text content
                            final String _name = _nameController.text;
                            final String _noPhone = _phoneController.text;
                            final String _description = _descController.text;

                            // Send File
                            final String? _filePath = _file!.path;
                            String _fileUrl =
                                await documentFileUpload(_filePath!);

                            // Send location
                            // Send list category
                            // Send to Firestore
                            // TODO:: Buatin fungsi tersendiri untuk add dan update
                            if (_isUpdate) {
                              Firestore.firebaseFirestore
                                  .collection('users')
                                  .doc(Auth.auth.currentUser!.uid)
                                  .collection('kelola_panti')
                                  .doc(_documentId)
                                  .update({
                                'name': _name,
                                'img_url': _imgUrl,
                                'description': _description,
                                'no_tlpn': _noPhone,
                                'address': _address,
                                'location': _location,
                                'document': _fileUrl,
                                'approved': false,
                                'kebutuhan': KebutuhanModel.convertToListMap(
                                    _listKebutuhan),
                              });

                              setState(() {
                                _isLoading = false;
                              });
                              Navigation.back();
                            } else {
                              Firestore.firebaseFirestore
                                  .collection('users')
                                  .doc(Auth.auth.currentUser!.uid)
                                  .collection('kelola_panti')
                                  .add({
                                'name': _name,
                                'img_url': _imgUrl,
                                'description': _description,
                                'no_tlpn': _noPhone,
                                'address': _address,
                                'location': _location,
                                'document': _fileUrl,
                                'approved': false,
                                'kebutuhan': KebutuhanModel.convertToListMap(
                                    _listKebutuhan),
                              });
                            }

                            setState(() {
                              _isLoading = false;
                            });
                            Navigation.back();
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            const snackBar = SnackBar(
                              content:
                                  Text('Mohon masukkan gambar panti asuhan'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      } catch (e) {
                        print(e);
                        const snackBar = SnackBar(
                          content: Text('Opss.. terjadi kesalahan, coba lagi'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
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
      child: (_isUpdate && _image == null)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                _pantiAsuhan!.imgUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
            )
          : (_isUpdate || _image != null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.file(
                    File(_image!.path),
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
        CustomTextFormField(
          hintText: 'Tulis nama panti asuhan',
          errorText: 'Masukkan nama panti asuhan',
          controller: _nameController,
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
        CustomTextFormField(
          hintText: 'Tulis nomor telepon panti asuhan',
          errorText: 'Masukkan nomor telepon panti asuhan',
          controller: _phoneController,
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
        CustomTextFormField(
          hintText: 'Tulis deskripsi panti asuhan',
          errorText: 'Masukkan deskripsi panti asuhan',
          controller: _descController,
        )
      ],
    );
  }

  Widget _buildFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Surat Keterangan",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: regular),
        ),
        const SizedBox(height: 5.0),
        GestureDetector(
          onTap: () async {
            var platformFile = await getFileAndUpload();
            setState(() {
              _file = platformFile;
            });
          },
          child: (_isUpdate && _file == null)
              ? Row(
                  children: [
                    Container(
                      height: 45.0,
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
                            'Perbarui Surat Keterangan',
                            style: purpleTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : (_isUpdate || _file != null)
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
    );
  }

  Widget _buildLocation() {
    return Column(
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

              _markers.clear();
              _markers.add(
                Marker(
                  markerId: MarkerId(_location!.latitude.toString()),
                  position: LatLng(_location!.latitude, _location!.longitude),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              );
            });
          },
          child: (_isUpdate && _location == null)
              ? Container(
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
                          child:
                              Image.asset('assets/icons/ic_add_location.png'),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Perbarui lokasi',
                          style: greyTextStyle.copyWith(
                            fontSize: 12.0,
                            fontWeight: regular,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : (_location != null)
                  ? SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: AbsorbPointer(
                          absorbing: true,
                          child: GoogleMap(
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  _location!.latitude, _location!.longitude),
                              zoom: 17,
                            ),
                            scrollGesturesEnabled: false,
                            zoomGesturesEnabled: false,
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                          ),
                        ),
                      ),
                    )
                  : Container(
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
                              child: Image.asset(
                                  'assets/icons/ic_add_location.png'),
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
                  print(_image?.path);
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
                  print(_image?.path);
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

  void _isUpdateData() {
    Map<String, dynamic>? _dataFromKelolaPage =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (_dataFromKelolaPage != null) {
      _isUpdate = true;

      PantiAsuhanModel _dataPantiAsuhan = _dataFromKelolaPage['panti_asuhan'];
      _documentId = _dataFromKelolaPage['document_id'];

      setState(() {
        _pantiAsuhan = _dataPantiAsuhan;
        _nameController.text = _pantiAsuhan!.name;
        _phoneController.text = _pantiAsuhan!.noTlpn;
        _descController.text = _pantiAsuhan!.description;

        _listKebutuhan.addAll(_dataPantiAsuhan.kebutuhan);
      });

      print(_listKebutuhan);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    super.dispose();
  }
}