import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';

class CartModel extends CartItem {
  const CartModel(super.quantity, super.total, super.bookItem);
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      json['quantity'].toString(),
      json['total'].toString(), // Cast to double
      json['bookDto'] != null ? BookItemModel.fromJson(json['bookDto']) : null,
    );
  }
}
