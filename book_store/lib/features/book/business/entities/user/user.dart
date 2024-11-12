import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? userId;
  final String? profileImage;
  final String? username;
  final String password;
  final String email;
  final String? phone;
  final String? fullname;
  final String? address;

  final String roleId;
  const User(this.userId, this.profileImage, this.username, this.password,
      this.email, this.phone, this.address, this.roleId, this.fullname);
  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      userId,
      profileImage,
      username,
      password,
      email,
      phone,
      fullname,
      address,
      roleId
    ];
  }
}
