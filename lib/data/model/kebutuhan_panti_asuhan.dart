import 'package:equatable/equatable.dart';

class KebutuhanPantiAsuhan extends Equatable {
  final String name;
  final String image;

  const KebutuhanPantiAsuhan({required this.name, required this.image});

  @override
  List<Object?> get props => [name, image];
}
