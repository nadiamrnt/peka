import 'package:equatable/equatable.dart';

class KebutuhanModel extends Equatable {
  final String name;
  final String image;

  const KebutuhanModel({required this.name, required this.image});

  static List<Map<String, dynamic>> convertToListMap(
      List<KebutuhanModel> listKebutuhan) {
    List<Map<String, dynamic>> listData = [];
    for (var element in listKebutuhan) {
      var dataMap = element.setDataMap();
      listData.add(dataMap);
    }
    return listData;
  }

  Map<String, dynamic> setDataMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  @override
  List<Object?> get props => [name, image];
}
