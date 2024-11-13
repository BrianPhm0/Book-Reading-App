// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/repositories/cart_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  CartRemoteDataSource cartRemoteDataSource;
  CartRepositoryImpl(
    this.cartRemoteDataSource,
  );

  @override
  Future<Either<Failure, String>> postCartItem(String id, int quantity) async {
    try {
      final postCartItem =
          await cartRemoteDataSource.postCartItem(id, quantity);
      if (postCartItem.isNotEmpty) {
        return right(postCartItem);
      }
      return left(Failure("Cant add item to Card"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCart() async {
    try {
      final postCartItem = await cartRemoteDataSource.getCart();
      if (postCartItem.isNotEmpty) {
        return right(postCartItem);
      }
      return left(Failure("Cant add item to Card"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteCart(String id) async {
    try {
      final deleteCart = await cartRemoteDataSource.deleteCart(id);
      if (deleteCart.isNotEmpty) {
        return right(deleteCart);
      }
      return left(Failure("Cant delete item from Card"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateItem(String id, int quantity) async {
    try {
      final res = await cartRemoteDataSource.updateItem(id, quantity);
      if (res.isNotEmpty) {
        return right(res);
      }
      return left(Failure("Cant update item from Cart"));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
