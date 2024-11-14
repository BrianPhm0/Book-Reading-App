import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:book_store/features/book/business/usecases/order/cancel_order.dart';
import 'package:book_store/features/book/business/usecases/order/get_order.dart';
import 'package:book_store/features/book/business/usecases/order/get_order_by_id.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrder _getOrder;

  final GetOrderById _getOrderById;

  final CancelOrder _cancelOrder;

 
  OrderBloc({
    required GetOrder getOrder,
    required GetOrderById getOrderById,
    required CancelOrder cancelOrder,
    
  })  : _getOrder = getOrder,
        _getOrderById = getOrderById,
        _cancelOrder = cancelOrder,
        
        super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<GetOrderEvent>(_onGetOrderEvent);
    on<GetOrderByIdEvent>(_onGetOrderByIdEvent);
    on<CancelOrderEvent>(_onCancelEvent);
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

  void _onGetOrderByIdEvent(
      GetOrderByIdEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final res = await _getOrderById(GetOrderIdParams(event.id));

    res.fold(
      (failure) {
        emit(OrderFailure(failure.message)); // emit failure state
      },
      (r) {
        emit(GetOrderIdSuccess(r)); // emit success state
      },
    );
  }

  void _onCancelEvent(CancelOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    final res = await _cancelOrder(CancelOrderParams(event.id));

    res.fold(
      (failure) {
        emit(OrderFailure(failure.message)); // emit failure state
      },
      (r) {
        emit(CancelOrderSuccess()); // emit success state
      },
    );
  }
}
