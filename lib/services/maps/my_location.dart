import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyLocation {
  static Location location = Location();

  static Future<LatLng> getMyPosition() async {
    var myLocation = await MyLocation.location.getLocation();
    return LatLng(myLocation.latitude!, myLocation.longitude!);
  }

  static Future<String> getAddress(double lat, double lang) async {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(lat, lang);
    geocoding.Placemark place = placemarks.first;
    String myAddressLocation =
        "${place.street}, ${place.postalCode}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
    return myAddressLocation;
  }
}
