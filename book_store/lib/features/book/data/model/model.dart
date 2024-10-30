import 'package:equatable/equatable.dart';

class Model extends Equatable {
  final String id;
  final String? image;
  final String? userName;
  final String password;
  final String email;
  final String? phone;
  final String? address;
  final String roleId;

  const Model(
    this.id,
    this.userName,
    this.password,
    this.email,
    this.phone,
    this.address,
    this.roleId,
    this.image,
  );

  @override
  List<Object?> get props {
    return [id, userName, image, password, email, phone, address, roleId];
  }

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        json['userId'],
        json['userName'],
        json['password'],
        json['email'],
        json['phone'],
        json['address'],
        json['roleId'],
        json['image'],
      );

  Map<String, dynamic> toJson() => {
        "userId": id,
        "userName": userName,
        "password": password,
        "email": email,
        "phone": phone,
        "address": address,
        "roleId": roleId,
        "image": image,
      };
}
