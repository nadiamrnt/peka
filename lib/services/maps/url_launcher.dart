import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> openMap(
      String startDestination, String endDestination) async {
    String googleMapUrl =
        "https://www.google.com/maps/dir/?api=1&origin=$startDestination&destination=$endDestination";

    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw 'Gagal mendapatkan lokasi';
    }
  }
}
