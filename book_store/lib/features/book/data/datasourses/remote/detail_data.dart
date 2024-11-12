import 'dart:convert';
import 'package:book_store/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:book_store/api_config.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';
import 'package:book_store/features/book/data/model/review/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class DetailData {
  Future<BookItemModel> getDetail(String id);
  Future<List<ReviewModel>> getReview(String id);
}

class DetailDataImpl implements DetailData {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Lấy token từ SharedPreferences
    return token;
  }

  @override
  Future<BookItemModel> getDetail(String id) async {
    final url = Uri.parse('${ApiConfig.detailBook}$id');
    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};
    try {
      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        // print(BookItemModel.fromJson(data));

        return BookItemModel.fromJson(data);
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }

  @override
  Future<List<ReviewModel>> getReview(String id) async {
    final url = Uri.parse('${ApiConfig.review}$id');
    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};
    try {
      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data.isNotEmpty) {
          final List<dynamic> items = data;

          List<ReviewModel> list = items.map((json) {
            return ReviewModel.fromJson(json);
          }).toList();

          return list;
        } else {
          List<ReviewModel> data = <ReviewModel>[];

          return data;
        }
      } else {
        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      throw ServerException('Error: ${e.toString()}');
    }
  }
}
