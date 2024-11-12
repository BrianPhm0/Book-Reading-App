import 'dart:convert';

import 'package:book_store/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class CheckData {
  Future<void> payCash(
      String name, String phone, String address, String? voucher);
}

@override
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token'); // Lấy token từ SharedPreferences
  return token;
}

class CheckDataImpl implements CheckData {
  @override
  Future<void> payCash(
      String name, String phone, String address, String? voucher) async {
    final url = Uri.parse(
        'http://localhost:7274/api/Orders/checkout'); // URL for the API endpoint
    final token =
        await getToken(); // Assuming getToken() returns the authentication token

    // Headers
    final headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json-patch+json',
    };

    // Request body (payload) to send as JSON
    final body = jsonEncode({
      "name": name,
      "phone": phone,
      "address": address,
      "code": voucher ??
          '', // Ensure voucher is passed as a valid string or empty if null
    });

    try {
      // Sending POST request
      final res = await http.post(url, headers: headers, body: body);

      // Check the response status
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
      } else {
        // If the status code is not 200, throw an exception
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      // Catch any errors in the request process and throw a custom exception
      throw ServerException('Error: ${e.toString()}');
    }
  }
}
