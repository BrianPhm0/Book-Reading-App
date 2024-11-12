// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/repositories/home_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl(
    this.homeRemoteDataSource,
  );
  @override
  Future<Either<Failure, List<BookItem>>> getBestDeal() async {
    try {
      final getBestDeal = await homeRemoteDataSource.getBestDeal();
      if (getBestDeal.isNotEmpty) {
        return right(getBestDeal);
      }
      return left(Failure('Cant get data'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookItem>>> getLatestBook() async {
    try {
      final getLatestBook = await homeRemoteDataSource.getLatestBook();
      if (getLatestBook.isNotEmpty) {
        return right(getLatestBook);
      }
      return left(Failure('Cant get data'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BookItem>>> getTopBook() async {
    try {
      final getTopBook = await homeRemoteDataSource.getTopBook();
      if (getTopBook.isNotEmpty) {
        return right(getTopBook);
      }
      return left(Failure('Cant get data'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
