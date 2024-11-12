import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/cart_repository.dart';
import 'package:fpdart/src/either.dart';

class DeleteCart implements UseCase<String, DeleteCartParams> {
  final CartRepository cartRepository;

  DeleteCart(this.cartRepository);

  @override
  Future<Either<Failure, String>> call(DeleteCartParams params) async {
    return await cartRepository.deleteCart(params.id);
  }
}

class DeleteCartParams {
  final String id;

  DeleteCartParams({required this.id});
}
