import 'package:book_store/features/book/business/entities/address/address.dart';

// Model Class extending the entity and adding serialization methods
class AddressModel extends Address {
  const AddressModel(super.name, super.phone, super.address);

  // Convert AddressModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
    };
  }

  // Factory constructor for creating AddressModel from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      json['name'],
      json['phone'],
      json['address'],
    );
  }
}
