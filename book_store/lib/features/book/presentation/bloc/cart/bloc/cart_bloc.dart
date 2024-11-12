import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/business/usecases/cart/delete_cart.dart';
import 'package:book_store/features/book/business/usecases/cart/get_cart.dart';
import 'package:book_store/features/book/business/usecases/cart/post_cart_item.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  //implement usecase
  final PostCartItem _postCartItem;
  final GetCart _getCart;
  final DeleteCart _deleteCart;

  CartBloc(
      {required PostCartItem postCartItem,
      required GetCart getCart,
      required DeleteCart deleteCart})
      : _postCartItem = postCartItem,
        _getCart = getCart,
        _deleteCart = deleteCart,
        super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<PostCartEvent>(_onPostCartEvent);
    on<GetCartEvent>(_onGetCartEvent);
    on<DeleteCartEvent>(_onDeleteCartEvent);
  }

  Future<String> _onPostCartEvent(
      PostCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _postCartItem(
        PostCartItemParams(id: event.id, quantity: event.quantity));

    return res.fold(
      (failure) {
        emit(CartFailure(failure.message));
        return failure.message; // Return failure message as a String
      },
      (r) {
        emit(PostCartSuccess(r));
        return "Success"; // Return success message or data as a String
      },
    );
  }

  Future<String> _onGetCartEvent(
      GetCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _getCart(NoParams());

    return res.fold(
      (failure) {
        emit(CartFailure(failure.message));
        return failure.message; // Return failure message as a String
      },
      (r) {
        emit(GetCartSuccess(r));
        return "Success"; // Return success message or data as a String
      },
    );
  }

  Future<String> _onDeleteCartEvent(
      DeleteCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _deleteCart(DeleteCartParams(id: event.id));

    return res.fold(
      (failure) {
        emit(CartFailure(failure.message));
        return failure.message; // Return failure message as a String
      },
      (r) {
        emit(DeleteCartSuccess(r));
        return "Success"; // Return success message or data as a String
      },
    );
  }
}
