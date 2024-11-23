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
  Future<void> postReview(String id, String rating, String comment);
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

    final headers = {'accept': '*/*'};
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
    // final token = await getToken();

    final headers = {'accept': '*/*'};
    try {
      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data.isNotEmpty) {
          final List<dynamic> items = data;

          List<ReviewModel> list = items.map((json) {
            // print(ReviewModel.fromJson(json));
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

  @override
  Future<void> postReview(String id, String rating, String comment) async {
    final url = Uri.parse(ApiConfig.postReview);

    final token = await getToken();

    try {
      // Create a MultipartRequest instead of using http.post
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        })
        ..fields['Comment'] = comment
        ..fields['BookId'] = id
        ..fields['Rating'] = rating;

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
