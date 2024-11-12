import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/cart_repository.dart';
import 'package:fpdart/src/either.dart';

class PostCartItem implements UseCase<String, PostCartItemParams> {
  final CartRepository cartRepository;

  PostCartItem(this.cartRepository);

  @override
  Future<Either<Failure, String>> call(PostCartItemParams params) async {
    return await cartRepository.postCartItem(params.id, params.quantity);
  }
}

class PostCartItemParams {
  final String id;
  final int quantity;

  PostCartItemParams({required this.id, required this.quantity});
}
