import 'package:book_store/features/book/business/entities/user.dart';

class UserModel extends User {
  const UserModel(super.id, super.userName, super.password, super.email,
      super.phone, super.address, super.roleId, super.image);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        map['id'] ?? '',
        map['userName'] ?? '',
        map['password'] ?? '',
        map['email'] ?? '',
        map['phone'] ?? '',
        map['address'] ?? '',
        map['roleId'] ?? '',
        map['image'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "password": password,
        "email": email,
        "phone": phone,
        "address": address,
        "roleId": roleId,
        "image": image,
      };
}
