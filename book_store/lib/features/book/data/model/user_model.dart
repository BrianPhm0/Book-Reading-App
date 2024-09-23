import 'package:book_store/features/book/business/entities/user.dart';

class UserModel extends User {
  const UserModel(super.id, super.userName, super.password, super.email,
      super.phone, super.address, super.roleId, super.image);

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'name': userName,
      'email': email,
      'phoneNumber': phone,
      'address': address,
      'role': roleId,
      'photoURL': image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        map['id'] ?? '',
        map['username'] ?? '',
        map['password'] ?? '',
        map['email'] ?? '',
        map['phone'] ?? '',
        map['address'] ?? '',
        map['roleId'] ?? '',
        map['image'] ?? '');
  }
}
