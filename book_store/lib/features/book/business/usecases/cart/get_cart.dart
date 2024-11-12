import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/business/repositories/cart_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCart implements UseCase<List<CartItem>, NoParams> {
  final CartRepository cartRepository;

  GetCart(this.cartRepository);

  @override
  Future<Either<Failure, List<CartItem>>> call(params) async {
    return await cartRepository.getCart();
  }
}
