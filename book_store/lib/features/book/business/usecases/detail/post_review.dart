import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/detail_repository.dart';
import 'package:fpdart/fpdart.dart';

class PostReview implements UseCase<void, PostReviewParams> {
  final DetailRepository detailRepository;

  PostReview(this.detailRepository);
  @override
  Future<Either<Failure, void>> call(PostReviewParams params) async {
    return await detailRepository.postReview(
        params.id, params.rating, params.comment);
  }
}

class PostReviewParams {
  final String id;
  final String rating;
  final String comment;

  PostReviewParams(this.id, this.rating, this.comment);
}
