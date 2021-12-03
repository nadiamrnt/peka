import 'package:equatable/equatable.dart';

class KebutuhanModel extends Equatable {
  final String name;
  final String image;

  const KebutuhanModel({required this.name, required this.image});

  @override
  List<Object?> get props => [name, image];
}
