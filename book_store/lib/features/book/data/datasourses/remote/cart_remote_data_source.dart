import 'package:book_store/api_config.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/data/model/cart/cart_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CartRemoteDataSource {
  Future<String> postCartItem(String id, int quantity);
  Future<List<CartModel>> getCart();
  Future<String> deleteCart(String id);
  Future<String> updateItem(String id, int quantity);
}

@override
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token'); // Lấy token từ SharedPreferences
  return token;
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  @override
  Future<String> postCartItem(
    String id,
    int quantity,
  ) async {
    final url =
        Uri.parse('${ApiConfig.postCartItem}productId=$id&quantity=$quantity');
    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};
    try {
      final res = await http.post(url, headers: headers);

      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }

  @override
  Future<List<CartModel>> getCart() async {
    final url = Uri.parse(ApiConfig.getCartItem);
    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data.isNotEmpty) {
          final List<dynamic> items = data;

          List<CartModel> list = items.map((json) {
            return CartModel.fromJson(json);
          }).toList();

          return list;
        } else {
          List<CartModel> data = <CartModel>[];

          return data;
        }
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }

  @override
  Future<String> deleteCart(String id) async {
    final url = Uri.parse('${ApiConfig.deleteCart}$id');
    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    try {
      final res = await http.delete(url, headers: headers);
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }

  @override
  Future<String> updateItem(String id, int quantity) async {
    final url = Uri.parse('${ApiConfig.updateItem}$id&quantity=$quantity');

    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};
    try {
      final res = await http.put(url, headers: headers);
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }
}
