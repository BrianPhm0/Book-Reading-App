import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<BookItem>>> getBestDeal();
  Future<Either<Failure, List<BookItem>>> getTopBook();
  Future<Either<Failure, List<BookItem>>> getLatestBook();
}
