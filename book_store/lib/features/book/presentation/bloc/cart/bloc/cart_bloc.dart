import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/business/usecases/cart/delete_cart.dart';
import 'package:book_store/features/book/business/usecases/cart/get_cart.dart';
import 'package:book_store/features/book/business/usecases/cart/post_cart_item.dart';
import 'package:book_store/features/book/business/usecases/cart/update_item.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  //implement usecase
  final PostCartItem _postCartItem;
  final GetCart _getCart;
  final DeleteCart _deleteCart;
  final UpdateItem _updateItem;

  CartBloc(
      {required PostCartItem postCartItem,
      required GetCart getCart,
      required UpdateItem updateItem,
      required DeleteCart deleteCart})
      : _postCartItem = postCartItem,
        _getCart = getCart,
        _deleteCart = deleteCart,
        _updateItem = updateItem,
        super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<PostCartEvent>(_onPostCartEvent);
    on<GetCartEvent>(_onGetCartEvent);
    on<DeleteCartEvent>(_onDeleteCartEvent);
    on<UpdateItemEvent>(_onUpdateItemEvent);
  }

  void _onPostCartEvent(PostCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _postCartItem(
        PostCartItemParams(id: event.id, quantity: event.quantity));

    res.fold(
      // ignore: void_checks
      (failure) {
        emit(CartFailure(failure.message));
        return failure.message; // Return failure message as a String
      },
      // ignore: void_checks
      (r) {
        return emit(PostCartSuccess(r));
      },
    );
  }

  void _onGetCartEvent(GetCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _getCart(NoParams());

    res.fold(
      // ignore: void_checks
      (failure) {
        emit(CartFailure(failure.message));
        return failure.message; // Return failure message as a String
      },
      // ignore: void_checks
      (r) {
        return emit(GetCartSuccess(r));
      },
    );
  }

  void _onUpdateItemEvent(
      UpdateItemEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _updateItem(
        UpdateItemParams(id: event.id, quantity: event.quantity));

    res.fold(
      (failure) {
        emit(CartFailure(failure.message));
      },
      (r) {
        return emit(UpdateCartSuccess(r));
      },
    );
  }

  void _onDeleteCartEvent(
      DeleteCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final res = await _deleteCart(DeleteCartParams(id: event.id));

    res.fold(
      // ignore: void_checks
      (failure) {
        emit(CartFailure(failure.message));
      },
      // ignore: void_checks
      (r) {
        return emit(DeleteCartSuccess(r));
      },
    );
  }
}
