import 'package:book_store/features/book/business/entities/user/user.dart';

class UserModel extends User {
  const UserModel(
      super.userId,
      super.profileImage,
      super.username,
      super.password,
      super.email,
      super.phone,
      super.address,
      super.roleId,
      super.fullname);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      map['user_id'] ?? '',
      map['profile_image'] ?? '',
      map['username'] ?? '',
      map['password'] ?? '',
      map['email'] ?? '',
      map['phone'] ?? '',
      map['fullname'] ?? '',
      map['address'] ?? '',
      map['roleId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "profile_image": profileImage,
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
        "fullname": fullname,
        "address": address,
        "roleId": roleId,
      };
}
