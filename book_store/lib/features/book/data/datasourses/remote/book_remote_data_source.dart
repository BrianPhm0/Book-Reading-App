import 'package:book_store/api_config.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:book_store/features/book/data/model/category/book_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class BookRemoteDataSource {
  Future<List<BookTypeModel>> getAllBookTypes();
  Future<List<BookItemModel>> getBooksByType(int bookTypeId);
  Future<List<BookItemModel>> getLatestBook();
  Future<List<BookItemModel>> getPurchaseEbook();
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final FirebaseFirestore firebaseBook;

  BookRemoteDataSourceImpl(this.firebaseBook);

  @override
  Future<List<BookTypeModel>> getAllBookTypes() async {
    final url = Uri.parse(ApiConfig.getCategory); // URL API
    final headers = {
      'accept': '*/*', // Header yêu cầu
    };

    try {
      final res = await http.get(url, headers: headers); // Gửi yêu cầu GET

      if (res.statusCode == 200) {
        // Nếu trạng thái HTTP là 200, tức là yêu cầu thành công
        var data = json.decode(res.body); // Giải mã phản hồi JSON

        // Chuyển đổi danh sách JSON thành danh sách BookTypeModel
        List<BookTypeModel> bookTypes = (data as List)
            .map((jsonItem) => BookTypeModel.fromJson(jsonItem))
            .toList();

        return bookTypes;
      } else {
        // Nếu không phải mã trạng thái 200, ném ra Exception

        throw Exception('Failed to load data. Status code: ${res.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi và ném ra một ngoại lệ nếu có lỗi xảy ra
      throw ServerException('Error: ${e.toString()}');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Lấy token từ SharedPreferences
    return token;
  }

  @override
  Future<List<BookItemModel>> getBooksByType(int bookTypeId) async {
    final url = Uri.parse(
        '${ApiConfig.getBookByCategory}$bookTypeId&pageNumber=1&pageSize=10');

    final headers = {'accept': '*/*'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data['items'] is List) {
          final List<dynamic> items =
              data['items']; // Lấy danh sách items từ API

          List<BookItemModel> list = items.map((bookJson) {
            return BookItemModel.fromJson(bookJson);
          }).toList();
          // print(items[0]);
          // print(list[0].description);

          return list;
          // print('Book List: $list'); // In ra danh sách sách
        } else {
          throw Exception('API response does not contain "items" as expected.');
        }
      } else {
        throw ServerException(
            'Failed to load books with status code: ${res.statusCode}');
      }
    } catch (e) {
      // print('Error: $e'); // In lỗi để debug
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookItemModel>> getLatestBook() async {
    final url = Uri.parse(ApiConfig.getLatestBook);

    final headers = {'accept': '*/*'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;
        // print(data);

        List<BookItemModel> list = data.map((bookJson) {
          // print(BookItemModel.fromJson(bookJson));
          return BookItemModel.fromJson(bookJson);
        }).toList();

        // print(list);

        return list;
      } else {
        throw ServerException(
            'Failed to load books with status code: ${res.statusCode}');
      }
    } catch (e) {
      // print('Error: $e'); // In lỗi để debug
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookItemModel>> getPurchaseEbook() async {
    final url = Uri.parse(ApiConfig.purchaseEbook);

    final token = await getToken();

    final headers = {'accept': '*/*', 'Authorization': 'Bearer $token'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data.isNotEmpty) {
          if (data['items'] is List) {
            final List<dynamic> items =
                data['items']; // Lấy danh sách items từ API

            List<BookItemModel> list = items.map((bookJson) {
              return BookItemModel.fromJson(bookJson);
            }).toList();
            // print(items[0]);
            // print(list[0].description);

            return list;
            // print('Book List: $list'); // In ra danh sách sách
          } else {
            throw Exception(
                'API response does not contain "items" as expected.');
          }
        } else {
          List<BookItemModel> data = <BookItemModel>[];
          return data;
        }
      } else {
        throw ServerException(
            'Failed to load books with status code: ${res.statusCode}');
      }
    } catch (e) {
      // print('Error: $e'); // In lỗi để debug
      throw ServerException(e.toString());
    }
  }
}
