import 'dart:convert';

import 'package:book_store/api_config.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/data/model/voucher/voucher_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class VoucherData {
  Future<List<VoucherModel>> getVoucherUser();
  Future<List<VoucherModel>> getPublicVoucher();
  Future<void> addVoucher(String id);
}

@override
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token'); // Lấy token từ SharedPreferences
  return token;
}

class VoucherDataImpl implements VoucherData {
  @override
  Future<List<VoucherModel>> getVoucherUser() async {
    final url = Uri.parse(ApiConfig.voucher);

    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;

        List<VoucherModel> list = data.map((bookJson) {
          return VoucherModel.fromJson(bookJson);
        }).toList();

        return list;
      } else {
        throw ServerException(
            'Failed to load books with status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<VoucherModel>> getPublicVoucher() async {
    final url = Uri.parse(ApiConfig.getPublicVoucher);

    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;

        List<VoucherModel> list = data.map((bookJson) {
          return VoucherModel.fromJson(bookJson);
        }).toList();

        return list;
      } else {
        throw ServerException(
            'Failed to load books with status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addVoucher(String id) async {
    final url = Uri.parse(ApiConfig.addVoucher);

    final token = await getToken();

    try {
      // Create a MultipartRequest instead of using http.post
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        })
        ..fields['voucherCode'] = id;

      // Send the request
      final streamedResponse = await request.send();

      // Read the response
      final res = await http.Response.fromStream(streamedResponse);

      if (res.statusCode == 200) {
      } else {
        throw ServerException(
            'Failed to add voucher with status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
