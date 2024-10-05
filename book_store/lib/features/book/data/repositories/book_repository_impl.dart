import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/entities/book_type.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:book_store/features/book/data/datasourses/book_remote_data_source.dart';

import 'package:fpdart/src/either.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource authRemoteDataSource;

  BookRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, List<BookType>>> getAllBookTypes() async {
    try {
      final listBookType = await authRemoteDataSource.getAllBookTypes();
      if (listBookType.isNotEmpty) {
        return right(listBookType);
      }
      return left(Failure('Cant get data of book type'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getBooksByTypes(
      {required int bookTypeId}) async {
    try {
      final listBooksType =
          await authRemoteDataSource.getBooksByType(bookTypeId);
      if (listBooksType.isNotEmpty) {
        return right(listBooksType);
      }
      return left(Failure('Can not get data'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
