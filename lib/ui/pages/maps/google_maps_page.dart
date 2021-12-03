import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/maps/bottom_sheet_maps.dart';
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
  final LatLng _initialCameraPosition = const LatLng(-2.548926, 118.0148634);

  @override
  void initState() {
    Permission.checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
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

          MyLocation.getAddress(onTap.latitude, onTap.longitude).then((value) {
            setState(() {
              _address = value;
            });
          });

          modalBottomSheetMaps(context, _address ?? 'Alamat tidak ditemukan');
        },
        markers: _markers,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    LatLng myLocation = await MyLocation.getMyPosition();

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: myLocation, zoom: 15)));

    MyLocation.getAddress(myLocation.latitude, myLocation.longitude)
        .then((value) {
      setState(() {
        _address = value;
      });
    });
  }
}
