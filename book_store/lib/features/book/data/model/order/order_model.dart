import 'package:book_store/features/book/business/entities/order/order_item.dart';

class OrderModel extends OrderItem {
  const OrderModel(super.orderId, super.orderDate, super.totalAmount,
      super.status, super.name, super.phone, super.address);

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    DateTime releaseDateTime = DateTime.parse(map['orderDate']);
    return OrderModel(
      map['orderId'].toString(),
      '${releaseDateTime.day}-${releaseDateTime.month}-${releaseDateTime.year}',
      map['totalAmount'].toString(),
      map['status'].toString(),
      map['name'].toString(),
      map['phone'].toString(),
      map['address'].toString(),
    );
  }
}
