// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/review/review.dart';
import 'package:book_store/features/book/data/datasourses/remote/detail_data.dart';
import 'package:book_store/features/book/data/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  DetailData detailData;
  DetailRepositoryImpl(
    this.detailData,
  );

  @override
  Future<Either<Failure, BookItem>> getDetail(String id) async {
    try {
      final detailBook = await detailData.getDetail(id);
      return right(detailBook);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getReview(String id) async {
    try {
      final review = await detailData.getReview(id);
      return right(review);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
