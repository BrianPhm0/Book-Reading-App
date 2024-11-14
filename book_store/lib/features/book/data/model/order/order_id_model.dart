import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';

class OrderIdModel extends OrderId {
  const OrderIdModel(super.quantity, super.book);
  factory OrderIdModel.fromJson(Map<String, dynamic> json) {
    return OrderIdModel(
      json['quantity'].toString(),
      json['booksDto'] != null
          ? BookItemModel.fromJson(json['booksDto'])
          : null,
    );
  }
}
