part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class ResetCartEvent extends CartEvent {}

final class PostCartEvent extends CartEvent {
  final String id;
  final int quantity;

  const PostCartEvent(this.id, this.quantity);
}

final class UpdateItemEvent extends CartEvent {
  final String id;
  final int quantity;

  const UpdateItemEvent(this.id, this.quantity);
}

final class DeleteCartEvent extends CartEvent {
  final String id;

  const DeleteCartEvent({required this.id});
}

final class GetCartEvent extends CartEvent {}
