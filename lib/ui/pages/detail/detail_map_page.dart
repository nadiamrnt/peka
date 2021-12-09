import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peka/data/model/panti_asuhan_model.dart';

import '../../../common/navigation.dart';
import '../../../common/styles.dart';

class DetailMapPage extends StatefulWidget {
  static const routeName = '/detail-map-page';
  const DetailMapPage({Key? key}) : super(key: key);

  @override
  State<DetailMapPage> createState() => _DetailMapPageState();
}

class _DetailMapPageState extends State<DetailMapPage> {
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final _pantiAsuhan =
        ModalRoute.of(context)?.settings.arguments as PantiAsuhanModel;

    LatLng _initialCameraPosition =
        LatLng(_pantiAsuhan.location.latitude, _pantiAsuhan.location.longitude);
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

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            indoorViewEnabled: false,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _initialCameraPosition,
              zoom: 16.0,
            ),
          ),
          _buildHeader(),
          _buildSetAddress(_pantiAsuhan),
        ]),
      ),
    );
  }

  Widget _buildSetAddress(PantiAsuhanModel pantiAsuhan) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: Column(
            children: [
              Text(
                'Alamat',
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                pantiAsuhan.address,
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: kWhiteBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigation.back(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back,
                color: kWhiteColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
