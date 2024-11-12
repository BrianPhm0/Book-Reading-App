import 'package:book_store/api_config.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

abstract interface class HomeRemoteDataSource {
  Future<List<BookItemModel>> getBestDeal();
  Future<List<BookItemModel>> getTopBook();
  Future<List<BookItemModel>> getLatestBook();
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  @override
  Future<List<BookItemModel>> getBestDeal() async {
    final url = Uri.parse(ApiConfig.getBestDeal);

    final headers = {'accept': '*/*'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;

        List<BookItemModel> list = data.map((bookJson) {
          return BookItemModel.fromJson(bookJson);
        }).toList();

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
  Future<List<BookItemModel>> getLatestBook() async {
    final url = Uri.parse(ApiConfig.getLatestBook);

    final headers = {'accept': '*/*'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;

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
  Future<List<BookItemModel>> getTopBook() async {
    final url = Uri.parse(ApiConfig.getTopBook);

    final headers = {'accept': '*/*'};

    try {
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        final data = json.decode(res.body) as List<dynamic>;

        List<BookItemModel> list = data.map((bookJson) {
          final bookItem = BookItemModel.fromJson(bookJson);

          return bookItem;
        }).toList();

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
}
