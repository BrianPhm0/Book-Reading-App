part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class GetOrderEvent extends OrderEvent {}

final class GetOrderByIdEvent extends OrderEvent {
  final String id;

  const GetOrderByIdEvent(this.id);
}

final class CancelOrderEvent extends OrderEvent {
  final String id;

  const CancelOrderEvent(this.id);
}
