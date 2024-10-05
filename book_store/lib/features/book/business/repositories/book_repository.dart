import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/entities/book_type.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class BookRepository {
  Future<Either<Failure, List<BookType>>> getAllBookTypes();
  Future<Either<Failure, List<Book>>> getBooksByTypes(
      {required int bookTypeId});
}
