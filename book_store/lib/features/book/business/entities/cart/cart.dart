import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int quantity;
  final int total;
  final BookItem? bookItem;

  const CartItem(this.quantity, this.total, this.bookItem);

  @override
  List<Object?> get props {
    return [quantity, total, bookItem];
  }
}
