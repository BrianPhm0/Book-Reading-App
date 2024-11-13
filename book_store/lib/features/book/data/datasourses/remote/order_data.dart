import 'dart:convert';

import 'package:book_store/api_config.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:book_store/features/book/data/model/order/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract interface class OrderData {
  Future<Map<String, List<OrderModel>>> getOrder();
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token'); // Lấy token từ SharedPreferences
  return token;
}

class OrderDataImpl implements OrderData {
  @override
  Future<Map<String, List<OrderModel>>> getOrder() async {
    final url = Uri.parse(ApiConfig.getOrder);
    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data['items'] is List) {
          final List<dynamic> items = data['items'];

          // Map JSON data to a list of OrderModel
          List<OrderModel> list = items.map((json) {
            return OrderModel.fromMap(json);
          }).toList();

          // Split list into "Processing" and "Completed" based on status
          List<OrderModel> processingOrders =
              list.where((order) => order.status == "Processing").toList();
          List<OrderModel> completedOrders =
              list.where((order) => order.status == "Completed").toList();

          return {
            'processing': processingOrders,
            'completed': completedOrders,
          };
        } else {
          return {
            'processing': [],
            'completed': [],
          };
        }
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }
}
