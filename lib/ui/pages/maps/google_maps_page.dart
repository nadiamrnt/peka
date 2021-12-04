import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  LatLng? myLocation;
  final LatLng _initialCameraPosition = const LatLng(-2.548926, 118.0148634);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    Permission.checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _initialCameraPosition,
            zoom: 15.0,
          ),
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          myLocationEnabled: true,
          onTap: (onTap) {
            _markers.clear();
            _markers.add(
              Marker(
                markerId: MarkerId(onTap.toString()),
                position: onTap,
                icon: BitmapDescriptor.defaultMarker,
              ),
            );

            MyLocation.getAddress(onTap.latitude, onTap.longitude)
                .then((value) {
              setState(() {
                _address = value;
              });
            });
          },
          markers: _markers,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              GeoPoint geoPoint =
                  GeoPoint(myLocation!.latitude, myLocation!.longitude);

              Navigator.pop(
                  context, {'address': _address, 'location': geoPoint});
            },
            child: const Text('Atur alamat'),
          ),
        )
      ]),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    myLocation = await MyLocation.getMyPosition();

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: myLocation!, zoom: 15)));

    MyLocation.getAddress(myLocation!.latitude, myLocation!.longitude)
        .then((value) {
      setState(() {
        _address = value;
      });
    });
  }

  Widget modalBottomSheetMaps(BuildContext context, String address) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          Text(address),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
