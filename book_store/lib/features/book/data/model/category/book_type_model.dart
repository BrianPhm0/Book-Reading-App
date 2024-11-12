import 'package:book_store/features/book/business/entities/categorybook/book_type.dart';

class BookTypeModel extends BookType {
  const BookTypeModel(super.bookTypeId, super.bookTypeName);

  factory BookTypeModel.fromJson(Map<String, dynamic> map) {
    return BookTypeModel(map['brandId'], map['name']);
  }
}
