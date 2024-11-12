import 'package:book_store/features/book/business/entities/cart/cart.dart';
import 'package:book_store/features/book/data/model/book_by_category/book_item_model.dart';

class CartModel extends CartItem {
  const CartModel({
    required int quantity,
    required int total,
    BookItemModel? book,
  }) : super(
          quantity,
          total,
          book,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      quantity: json['quantity'],
      total: json['total'],
      book: BookItemModel.fromJson(json['bookDto']),
    );
  }
}
