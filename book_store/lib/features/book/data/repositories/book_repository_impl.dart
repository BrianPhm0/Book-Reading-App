import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/categorybook/book_type.dart';
// import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/book_remote_data_source.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';

import 'package:fpdart/src/either.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource bookRemoteDataSource;

  BookRepositoryImpl(this.bookRemoteDataSource);

  @override
  Future<Either<Failure, List<BookType>>> getAllBookTypes() async {
    try {
      final listBookType = await bookRemoteDataSource.getAllBookTypes();
      if (listBookType.isNotEmpty) {
        return right(listBookType);
      }
      return left(Failure('Cant get data of book type'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookItem>>> getBooksByTypes(
      {required int bookTypeId}) async {
    try {
      final listBooksType =
          await bookRemoteDataSource.getBooksByType(bookTypeId);
      if (listBooksType.isNotEmpty) {
        return right(listBooksType);
      }
      return left(Failure('Can not get data'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookItem>>> getLatestBook() async {
    try {
      final latestBook = await bookRemoteDataSource.getLatestBook();
      if (latestBook.isNotEmpty) {
        return right(latestBook);
      }
      return left(Failure('Can not get data'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookItem>>> getPurchaseEbook() async {
    try {
      final purchaseEbook = await bookRemoteDataSource.getPurchaseEbook();

      return right(purchaseEbook);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookItemModel>>> searchEbook(
      String? name, String? pageNumber, String? pageSize) async {
    try {
      final purchaseEbook =
          await bookRemoteDataSource.searchEbook(name, pageNumber, pageSize);

      return right(purchaseEbook);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
