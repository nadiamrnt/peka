import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';

import '../../../common/navigation.dart';
import '../../../services/firebase/firestore/firestore.dart';
import '../../widgets/button.dart';
import 'detail_map_page.dart';
import 'send_donation_page.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detail-page';

  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final _pantiAsuhan =
        ModalRoute.of(context)?.settings.arguments as PantiAsuhanModel;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(_pantiAsuhan),
              const SizedBox(height: 30),
              _buildContent(_pantiAsuhan),
              const SizedBox(height: 15),
              _buildCategory(_pantiAsuhan),
              const SizedBox(height: 30),
              _buildLocation(_pantiAsuhan),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Button(
                    textButton: 'Donasi',
                    onTap: () {
                      _modalBottomSheetMenu(context, _pantiAsuhan);
                    }),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(PantiAsuhanModel pantiAsuhan) {
    return Padding(
      padding:
          EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigation.back(),
                child: Image.asset(
                  'assets/icons/ic_back.png',
                  width: 32,
                ),
              ),
              Expanded(
                child: Text(
                  'Detail',
                  textAlign: TextAlign.center,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: 328,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pantiAsuhan.imgUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PantiAsuhanModel pantiAsuhan) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: Firestore.firebaseFirestore
          .collection('panti_asuhan')
          .doc(pantiAsuhan.pantiAsuhanId)
          .collection('daftar_donatur')
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return Center(
              child: lottie.LottieBuilder.asset('assets/raw/loading.json'));
        }

        var dataDonatur = snapshot.data!.docs;
        if (snapshot.data!.docs.isNotEmpty) {
          dataDonatur.add(snapshot.data!.docs.last);
        }

        int donaturLenght = dataDonatur.length;

        return Padding(
          padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pantiAsuhan.name,
                style:
                    blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
              ),
              const SizedBox(height: 7),
              SizedBox(
                width: double.infinity,
                child: snapshot.data!.docs.length >= 2
                    ? Stack(
                        children: dataDonatur
                            .asMap()
                            .entries
                            .toList()
                            .map(
                              (item) {
                                int index = item.key;
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.firebaseFirestore
                                        .collection('users')
                                        .doc(item.value.get('owner_id'))
                                        .snapshots(),
                                    builder: (_, userData) {
                                      if (!userData.hasData) {
                                        return Wrap();
                                      }
                                      return (index == 0)
                                          ? Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 1,
                                                  color: kWhiteBgColor,
                                                ),
                                              ),
                                              child: ClipOval(
                                                child: Image.network(
                                                    userData.data
                                                        ?.get('img_profile'),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : (index == 4 && donaturLenght > 5 ||
                                                  index == 4 &&
                                                      donaturLenght == 5 ||
                                                  index == 3 &&
                                                      donaturLenght == 4 ||
                                                  index == 2 &&
                                                      donaturLenght == 3)
                                              ? Positioned(
                                                  left: (index == 3 &&
                                                          donaturLenght == 4)
                                                      ? 82
                                                      : index == 2 &&
                                                              donaturLenght == 3
                                                          ? 62
                                                          : index == 4 &&
                                                                  donaturLenght ==
                                                                      5
                                                              ? 104
                                                              : 104,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 30,
                                                    child: Text(
                                                      (index == 4 &&
                                                              donaturLenght > 5)
                                                          ? '+${donaturLenght - 1 - index} Berdonasi'
                                                          : 'Berdonasi',
                                                      style: greyTextStyle,
                                                    ),
                                                  ),
                                                )
                                              : Positioned(
                                                  left: (index * 22),
                                                  child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        width: 1,
                                                        color: kWhiteBgColor,
                                                      ),
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.network(
                                                          userData.data?.get(
                                                              'img_profile'),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                );
                                    });
                              },
                            )
                            .toList()
                            .getRange(
                                0, (donaturLenght > 5) ? 5 : donaturLenght)
                            .toList(),
                      )
                    : Row(
                        children: [
                          Image.asset(
                            'assets/icons/ic_location.png',
                            width: 11,
                            height: 14,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            pantiAsuhan.address.split(', ')[4],
                            style: greyTextStyle.copyWith(
                                fontSize: 14, fontWeight: regular),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 15),
              Text(
                pantiAsuhan.description,
                style:
                    greyTextStyle.copyWith(height: 1.75, fontWeight: regular),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategory(PantiAsuhanModel pantiAsuhan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            'Kebutuhan',
            style: blackTextStyle.copyWith(fontWeight: medium, fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 75,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 24),
            children: pantiAsuhan.kebutuhan.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pantiAsuhan.kebutuhan.indexOf(item).isEven
                            ? kBlueBgColor
                            : kPinkBgColor,
                      ),
                      child: Image.asset(
                        item.image,
                        width: 30,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.name,
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

  Widget _buildLocation(PantiAsuhanModel pantiAsuhan) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(pantiAsuhan.location.longitude.toString()),
          position: LatLng(
              pantiAsuhan.location.latitude, pantiAsuhan.location.longitude),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });

    return Padding(
      padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lokasi',
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              await Navigation.intentWithData(
                  DetailMapPage.routeName, pantiAsuhan);
            },
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 3,
                  color: kWhiteBgColor,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: AbsorbPointer(
                  absorbing: true,
                  child: GoogleMap(
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(pantiAsuhan.location.latitude,
                          pantiAsuhan.location.longitude),
                      zoom: 17,
                    ),
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              pantiAsuhan.address,
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu(
      BuildContext context, PantiAsuhanModel pantiAsuhan) async {
    await showModalBottomSheet(
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
                textButton: 'Kirim Donasi',
                onTap: () async {
                  await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SendDonationPage(pantiAsuhan: pantiAsuhan),
                      ));
                },
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  Navigation.back();
                },
                child: Text(
                  'Donasi Langsung',
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
}
