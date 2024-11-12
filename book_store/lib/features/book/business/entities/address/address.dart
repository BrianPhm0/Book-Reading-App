import 'package:equatable/equatable.dart';

// Entity Class
class Address extends Equatable {
  final String name;
  final String phone;
  final String address;

  const Address(this.name, this.phone, this.address);

  @override
  List<Object?> get props => [name, phone, address];
}
