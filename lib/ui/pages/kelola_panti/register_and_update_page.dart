import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';
import 'package:peka/ui/widgets/button.dart';
import 'package:peka/ui/widgets/custom_text_form_field.dart';
import 'package:peka/ui/widgets/toast.dart';
import 'package:peka/utils/category_helper.dart';
import 'package:peka/utils/file_picker_helper.dart';
import 'package:peka/utils/firebase_storage_helper.dart';

import '../../../common/navigation.dart';
import '../../../data/model/kebutuhan_model.dart';
import '../../../services/firebase/auth/auth.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../../utils/image_picker_helper.dart';
import 'maps/google_maps_page.dart';

class RegisterAndUpdatePage extends StatefulWidget {
  static const routeName = '/register-page';
  final PantiAsuhanModel? pantiAsuhan;

  const RegisterAndUpdatePage({Key? key, this.pantiAsuhan}) : super(key: key);

  @override
  State<RegisterAndUpdatePage> createState() => _RegisterAndUpdatePageState();
}

class _RegisterAndUpdatePageState extends State<RegisterAndUpdatePage> {
  final List<KebutuhanModel> _listKebutuhan = [];
  String? _address;
  GeoPoint? _location;
  GoogleMapController? _googleMapController;

  File? _image;
  PlatformFile? _file;

  String? _imgUrl;
  String? _fileUrl;

  final Set<Marker> _markers = {};

  bool _isLoading = false;

  // controller text
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // isUpdate page
  bool _isUpdate = false;

  @override
  void initState() {
    _isUpdateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          color: kGreyBgColor,
          progressIndicator:
              lottie.LottieBuilder.asset('assets/raw/loading.json'),
          isLoading: _isLoading,
          opacity: 0.7,
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
                      textButton: _isUpdate ? 'Update' : 'Kirim',
                      onTap: _registerOrUpdateButton),
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
                widget.pantiAsuhan!.imgUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
            )
          : (_isUpdate || _image != null)
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
    if (_location != null) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId(_location!.latitude.toString()),
            position: LatLng(_location!.latitude, _location!.longitude),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    }

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
            try {
              final getData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GoogleMapsPage()));
              _address = getData['address'];

              setState(() {
                _location = getData['location'];
              });

              if (_googleMapController != null) {
                await _googleMapController?.moveCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target:
                            LatLng(_location!.latitude, _location!.longitude),
                        zoom: 17)));
              }
            } catch (e) {
              const Toast(toastTitle: 'Pilih lokasi dibatalkan')
                  .failedToast()
                  .show(context);
            }
          },
          child: (_isUpdate && _location == null)
              ? SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: ClipRRect(
                    child: AbsorbPointer(
                      absorbing: true,
                      child: GoogleMap(
                        markers: _markers,
                        onMapCreated: (controller) async {
                          _googleMapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.pantiAsuhan!.location.latitude,
                              widget.pantiAsuhan!.location.longitude),
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
                            onMapCreated: (controller) async {
                              _googleMapController = controller;
                            },
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
                  try {
                    await ImagePickerHelper.imgFromCamera().then((image) {
                      setState(() {
                        _image = image;
                      });
                    });
                  } catch (e) {
                    const Toast(toastTitle: 'Opss.. gagal mengambil gambar')
                        .failedToast()
                        .show(context);
                  }

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

  void _isUpdateData() {
    if (widget.pantiAsuhan != null) {
      _isUpdate = true;

      setState(() {
        _nameController.text = widget.pantiAsuhan!.name;
        _phoneController.text = widget.pantiAsuhan!.noTlpn;
        _descController.text = widget.pantiAsuhan!.description;

        _fileUrl = widget.pantiAsuhan!.documentUrl;
        _imgUrl = widget.pantiAsuhan!.imgUrl;
        _address = widget.pantiAsuhan!.address;

        _markers.clear();
        _markers.add(
          Marker(
            markerId:
                MarkerId(widget.pantiAsuhan!.location.latitude.toString()),
            position: LatLng(widget.pantiAsuhan!.location.latitude,
                widget.pantiAsuhan!.location.longitude),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );

        _listKebutuhan.addAll(widget.pantiAsuhan!.kebutuhan);
      });
    }
  }

  void _registerOrUpdateButton() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        if (_isUpdate) {
          await _updateData();
          setState(() => _isLoading = false);
          Navigation.back();
        } else if (_image != null &&
            _file != null &&
            _location != null &&
            _listKebutuhan.isNotEmpty) {
          await _registerData();
          setState(() => _isLoading = false);
          Navigation.back();
        } else {
          const Toast(toastTitle: 'Mohon lengkapi registrasi panti asuhan anda')
              .failedToast()
              .show(context);
        }
      }
    } catch (e) {
      const Toast(toastTitle: 'Opss.. terjadi kesalahan, coba lagi')
          .failedToast()
          .show(context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateData() async {
    // Send Image
    if (_image != null) {
      _imgUrl = await FirebaseStorageHelper.uploadImagePantiAsuhan(_image!);
    }

    // Send File
    if (_file != null) {
      final String? _filePath = _file!.path;
      _fileUrl = await documentFileUpload(_filePath!);
    }

    // Send text content
    final String _name = _nameController.text;
    final String _noPhone = _phoneController.text;
    final String _description = _descController.text;

    print(widget.pantiAsuhan!.pantiAsuhanId);

    PantiAsuhanModel dataPantiAsuhan = PantiAsuhanModel(
      pantiAsuhanId: widget.pantiAsuhan!.pantiAsuhanId,
      ownerId: widget.pantiAsuhan!.ownerId,
      name: _name,
      description: _description,
      noTlpn: _noPhone,
      imgUrl: _imgUrl!,
      documentUrl: _fileUrl!,
      address: _address ?? widget.pantiAsuhan!.address,
      location: _location ?? widget.pantiAsuhan!.location,
      approved: false,
      kebutuhan: _listKebutuhan,
    );

    await Firestore.firebaseFirestore
        .collection('users')
        .doc(Auth.firebaseAuth.currentUser!.uid)
        .collection('kelola_panti')
        .doc(widget.pantiAsuhan?.pantiAsuhanId)
        .update(dataPantiAsuhan.setDataMap());

    await Firestore.firebaseFirestore
        .collection('panti_asuhan')
        .doc(widget.pantiAsuhan?.pantiAsuhanId)
        .set(dataPantiAsuhan.setDataMap());
  }

  Future<void> _registerData() async {
    // Send Image
    _imgUrl = await FirebaseStorageHelper.uploadImagePantiAsuhan(_image!);

    // Send File
    final String? _filePath = _file!.path;
    _fileUrl = await documentFileUpload(_filePath!);

    // Send text content
    final String _name = _nameController.text;
    final String _noPhone = _phoneController.text;
    final String _description = _descController.text;

    PantiAsuhanModel dataPantiAsuhan = PantiAsuhanModel(
      pantiAsuhanId: '',
      ownerId: Auth.firebaseAuth.currentUser!.uid,
      name: _name,
      description: _description,
      noTlpn: _noPhone,
      imgUrl: _imgUrl!,
      documentUrl: _fileUrl!,
      address: _address!,
      location: _location!,
      approved: false,
      kebutuhan: _listKebutuhan,
    );

    await Firestore.firebaseFirestore
        .collection('users')
        .doc(Auth.firebaseAuth.currentUser!.uid)
        .collection('kelola_panti')
        .add(dataPantiAsuhan.setDataMap())
        .then((value) async {
      await Firestore.firebaseFirestore
          .collection('users')
          .doc(Auth.firebaseAuth.currentUser!.uid)
          .collection('kelola_panti')
          .doc(value.id)
          .update({'panti_asuhan_id': value.id});

      PantiAsuhanModel dataPantiAsuhanWithId = PantiAsuhanModel(
        pantiAsuhanId: value.id,
        ownerId: Auth.firebaseAuth.currentUser!.uid,
        name: _name,
        description: _description,
        noTlpn: _noPhone,
        imgUrl: _imgUrl!,
        documentUrl: _fileUrl!,
        address: _address!,
        location: _location!,
        approved: false,
        kebutuhan: _listKebutuhan,
      );

      await Firestore.firebaseFirestore
          .collection('panti_asuhan')
          .doc(value.id)
          .set(dataPantiAsuhanWithId.setDataMap())
          .then((pantiId) => Firestore.firebaseFirestore
              .collection('panti_asuhan')
              .doc(value.id)
              .collection('daftar_donatur')
              .doc('empty_donatur')
              .set({'owner_image': ''}));
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    super.dispose();
  }
}
