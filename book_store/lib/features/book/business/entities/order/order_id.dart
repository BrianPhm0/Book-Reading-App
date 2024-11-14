import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:equatable/equatable.dart';

class OrderId extends Equatable {
  final String quantity;
  final BookItem? book;

  const OrderId(this.quantity, this.book);

  @override
  // TODO: implement props
  List<Object?> get props => [quantity, book];
}
