import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:book_store/features/book/business/usecases/cart/get_cart.dart';
import 'package:book_store/features/book/business/usecases/order/get_order.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrder _getOrder;
  OrderBloc({required GetOrder getOrder})
      : _getOrder = getOrder,
        super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<GetOrderEvent>(_onGetOrderEvent);
  }
  void _onGetOrderEvent(GetOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final res = await _getOrder(NoParams());

    res.fold(
      (failure) {
        emit(OrderFailure(failure.message)); // emit failure state
      },
      (r) {
        emit(GetOrderSuccess(r)); // emit success state
      },
    );
  }
}
