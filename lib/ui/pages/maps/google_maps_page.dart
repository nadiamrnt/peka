import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:peka/common/styles.dart';
import 'package:peka/ui/widgets/button.dart';

import '../../../common/navigation.dart';
import '../../../services/maps/my_location.dart';
import '../../../services/maps/permission.dart';

class GoogleMapsPage extends StatefulWidget {
  static const routeName = '/google-maps-page';

  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  String? _address;
  final Set<Marker> _markers = {};
  LatLng? _myLocation;
  final LatLng _initialCameraPosition = const LatLng(-2.548926, 118.0148634);

  @override
  void initState() {
    Permission.checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          indoorViewEnabled: false,
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: _initialCameraPosition,
            zoom: 16.0,
          ),
          onTap: (onTap) {
            _markers.clear();
            _markers.add(
              Marker(
                markerId: MarkerId(onTap.toString()),
                position: onTap,
                icon: BitmapDescriptor.defaultMarker,
              ),
            );

            setState(() {
              _myLocation = LatLng(onTap.latitude, onTap.longitude);
            });

            MyLocation.getAddress(onTap.latitude, onTap.longitude)
                .then((value) {
              setState(() {
                _address = value;
              });
            });
          },
        ),
        _buildHeader(),
        _buildSetAddress(),
      ]),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _myLocation = await MyLocation.getMyPosition();

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _myLocation!, zoom: 15)));

    MyLocation.getAddress(_myLocation!.latitude, _myLocation!.longitude)
        .then((value) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId(_myLocation.toString()),
            position: LatLng(_myLocation!.latitude, _myLocation!.longitude),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
        _address = value;
      });
    });
  }

  Widget _buildSetAddress() {
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
                _address ?? "Silahkan pilih lokasi panti asuhan anda",
                style: blackTextStyle.copyWith(
                  fontWeight: regular,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Button(
                textButton: "Terapkan alamat",
                onTap: () {
                  GeoPoint geoPoint =
                      GeoPoint(_myLocation!.latitude, _myLocation!.longitude);

                  Navigator.pop(
                      context, {'address': _address, 'location': geoPoint});
                },
              ),
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
