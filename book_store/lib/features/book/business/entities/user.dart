import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? image;
  final String? userName;
  final String password;
  final String email;
  final String? phone;
  final String? address;
  final String roleId;
  const User(this.id, this.userName, this.password, this.email, this.phone,
      this.address, this.roleId, this.image);
  @override
  // TODO: implement props
  List<Object?> get props {
    return [id, userName, image, password, email, phone, address, roleId];
  }
}
