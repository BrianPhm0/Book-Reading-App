import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String orderId;
  final String orderDate;
  final String totalAmount;
  final String status;
  final String name;
  final String phone;
  final String address;

  const OrderItem(this.orderId, this.orderDate, this.totalAmount, this.status,
      this.name, this.phone, this.address);

  @override
  // TODO: implement props
  List<Object?> get props => [
        orderId,
        orderDate,
        totalAmount,
        status,
        name,
        phone,
        address
      ];
}
