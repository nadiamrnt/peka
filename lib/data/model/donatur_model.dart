import 'package:cloud_firestore/cloud_firestore.dart';

import 'kebutuhan_model.dart';

class DonaturModel {
  final String userId;
  final String donationId;
  final String courier;
  final String note;
  final String noReceipt;
  final String imgDonation;
  final Timestamp date;
  final List<KebutuhanModel> donation;

  DonaturModel({
    required this.userId,
    required this.donationId,
    required this.courier,
    required this.note,
    required this.noReceipt,
    required this.imgDonation,
    required this.date,
    required this.donation,
  });

  factory DonaturModel.fromDatabase(DocumentSnapshot? data) => DonaturModel(
        userId: data?.get('owner_id') ?? '',
        donationId: data?.get('donation_id') ?? '',
        courier: data?.get('courier') ?? '',
        note: data?.get('note') ?? '',
        noReceipt: data?.get('no_receipt') ?? '',
        imgDonation: data?.get('img_donation') ?? '',
        date: data?.get('date') ?? '',
        donation: List<KebutuhanModel>.from(
          data?.get('donation').map((item) {
                return KebutuhanModel(name: item['name'], image: item['image']);
              }) ??
              <KebutuhanModel>[],
        ),
      );

  Map<String, dynamic> setDataMap() {
    return {
      "owner_id": userId,
      "donation_id": donationId,
      "courier": courier,
      "note": note,
      "no_receipt": noReceipt,
      "img_donation": imgDonation,
      "date": date,
      "donation": KebutuhanModel.convertToListMap(donation),
    };
  }
}
