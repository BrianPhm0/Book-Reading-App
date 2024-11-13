import 'package:book_store/core/error/failure.dart';

import 'package:book_store/features/book/business/entities/cart/cart.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, String>> postCartItem(String id, int quantity);

  Future<Either<Failure, List<CartItem>>> getCart();
  Future<Either<Failure, String>> deleteCart(String id);

  Future<Either<Failure, String>> updateItem(String id, int quantity);
}
