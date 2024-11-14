import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/review/review.dart';
import 'package:book_store/features/book/business/repositories/detail_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetReview implements UseCase<List<Review>, ReviewParams> {
  final DetailRepository detailRepository;

  GetReview(this.detailRepository);

  @override
  Future<Either<Failure, List<Review>>> call(ReviewParams params) async {
    return await detailRepository.getReview(params.id);
  }
}

class ReviewParams {
  final String id;

  ReviewParams({required this.id});
}
