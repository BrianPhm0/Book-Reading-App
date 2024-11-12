import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/review/review.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DetailRepository {
  Future<Either<Failure, BookItem>> getDetail(String id);

  Future<Either<Failure, List<Review>>> getReview(String id);
}
