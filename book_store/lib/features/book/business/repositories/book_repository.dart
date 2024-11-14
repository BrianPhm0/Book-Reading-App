import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/categorybook/book_type.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class BookRepository {
  Future<Either<Failure, List<BookType>>> getAllBookTypes();
  Future<Either<Failure, List<BookItem>>> getBooksByTypes(
      {required int bookTypeId});

  Future<Either<Failure, List<BookItem>>> getLatestBook();
  Future<Either<Failure, List<BookItem>>> getPurchaseEbook();
  Future<Either<Failure, List<BookItemModel>>> searchEbook(
      String? name, String? pageNumber, String? pageSize);
}
