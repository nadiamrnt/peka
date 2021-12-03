import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peka/data/model/kebutuhan_model.dart';

class PantiAsuhanModel {
  final String name;
  final String description;
  final String noTlpn;
  final String imgUrl;
  final String address;
  final GeoPoint location;
  final List<KebutuhanModel> kebutuhan;

  PantiAsuhanModel({
    required this.name,
    required this.description,
    required this.noTlpn,
    required this.imgUrl,
    required this.address,
    required this.location,
    required this.kebutuhan,
  });

  factory PantiAsuhanModel.fromDatabase(DocumentSnapshot? data) =>
      PantiAsuhanModel(
        name: data?.get('name') ?? '',
        description: data?.get('description') ?? '',
        noTlpn: data?.get('no_tlpn') ?? '',
        imgUrl: data?.get('img_url') ?? '',
        address: data?.get('address') ?? '',
        location: data?.get('location') ?? '',
        kebutuhan: List<KebutuhanModel>.from(
          data?.get('kebutuhan').map((item) {
                return KebutuhanModel(name: item['name'], image: item['image']);
              }) ??
              <KebutuhanModel>[],
        ),
      );

  Map<String, dynamic> setDataMap() {
    return {
      "name": name,
      "description": description,
      "no_tlpn": noTlpn,
      "img_url": imgUrl,
      "address": address,
      "location": location,
      "kebutuhan": noTlpn,
    };
  }
}
