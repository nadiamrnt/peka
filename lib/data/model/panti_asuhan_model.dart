import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peka/data/model/kebutuhan_model.dart';

class PantiAsuhanModel {
  final String pantiAsuhanId;
  final String ownerId;
  final String name;
  final String description;
  final String noTlpn;
  final String imgUrl;
  final String documentUrl;
  final String address;
  final GeoPoint location;
  final bool approved;
  final List<KebutuhanModel> kebutuhan;

  PantiAsuhanModel({
    required this.pantiAsuhanId,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.noTlpn,
    required this.imgUrl,
    required this.documentUrl,
    required this.address,
    required this.location,
    required this.approved,
    required this.kebutuhan,
  });

  factory PantiAsuhanModel.fromDatabase(DocumentSnapshot? data) =>
      PantiAsuhanModel(
        pantiAsuhanId: data?.get('panti_asuhan_id') ?? '',
        ownerId: data?.get('owner_id') ?? '',
        name: data?.get('name') ?? '',
        description: data?.get('description') ?? '',
        noTlpn: data?.get('no_tlpn') ?? '',
        imgUrl: data?.get('img_url') ?? '',
        documentUrl: data?.get('document_url') ?? '',
        address: data?.get('address') ?? '',
        location: data?.get('location') ?? '',
        approved: data?.get('approved') ?? '',
        kebutuhan: List<KebutuhanModel>.from(
          data?.get('kebutuhan').map((item) {
                return KebutuhanModel(name: item['name'], image: item['image']);
              }) ??
              <KebutuhanModel>[],
        ),
      );

  Map<String, dynamic> setDataMap() {
    return {
      "panti_asuhan_id": pantiAsuhanId,
      "owner_id": ownerId,
      "name": name,
      "description": description,
      "no_tlpn": noTlpn,
      "img_url": imgUrl,
      "document_url": documentUrl,
      "address": address,
      "location": location,
      "approved": approved,
      "kebutuhan": KebutuhanModel.convertToListMap(kebutuhan),
    };
  }
}
