import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';

import '../../../common/navigation.dart';
import '../../widgets/button.dart';
import 'detail_map_page.dart';

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

    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(_pantiAsuhan.location.longitude.toString()),
          position: LatLng(
              _pantiAsuhan.location.latitude, _pantiAsuhan.location.longitude),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });

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
                child: Button(textButton: 'Navigasi', onTap: () {}),
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
    return Padding(
      padding: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pantiAsuhan.name,
            style: blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Image.asset(
                'assets/icons/ic_location.png',
                width: 11,
                height: 14,
              ),
              const SizedBox(width: 7),
              Text(
                pantiAsuhan.address.split(', ')[4],
                style:
                    greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            pantiAsuhan.description,
            style: greyTextStyle.copyWith(height: 1.75, fontWeight: regular),
          ),
        ],
      ),
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
            child: SizedBox(
              height: 170,
              width: double.infinity,
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
}
