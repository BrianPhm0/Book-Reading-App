import 'dart:convert';

import 'package:book_store/features/book/data/model/address/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<void> saveAddress(String name, String phone, String address);
  Future<List<AddressModel>> getAddress();
  Future<String?> getToken();
}

class LocalDataImpl implements LocalData {
  static const _addressKey = 'order_addresses';

  @override
  Future<List<AddressModel>> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_addressKey);

    if (encodedData != null) {
      final List<dynamic> decodedData = json.decode(encodedData);
      return decodedData.map((item) => AddressModel.fromJson(item)).toList();
    }
    return []; // Return an empty list if no data is found
  }

  @override
  Future<void> saveAddress(String name, String phone, String address) async {
    final prefs = await SharedPreferences.getInstance();

    final List<AddressModel> currentAddresses = await getAddress();

    final newAddress = AddressModel(name, phone, address);

    currentAddresses.add(newAddress);

    final String encodedData =
        json.encode(currentAddresses.map((e) => e.toJson()).toList());
    await prefs.setString(_addressKey, encodedData);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Lấy token từ SharedPreferences

    return token;
  }
}
