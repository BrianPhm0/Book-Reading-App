part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class PostCartSuccess extends CartState {
  final String result;

  const PostCartSuccess(this.result);
}

final class GetCartSuccess extends CartState {
  final List<CartItem> cart;

  const GetCartSuccess(this.cart);
}

final class DeleteCartSuccess extends CartState {
  final String result;

  const DeleteCartSuccess(this.result);
}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final String? message;

  const CartFailure(this.message);
}
