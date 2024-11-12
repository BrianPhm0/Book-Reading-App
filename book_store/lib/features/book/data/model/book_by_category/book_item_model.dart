import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';

class BookItemModel extends BookItem {
  const BookItemModel(
    super.bookId,
    super.title,
    super.brandId,
    super.price,
    super.quantity,
    super.typeBookId,
    super.description,
    super.ebook,
    super.image,
    super.authorName,
    super.rating,
  );

  factory BookItemModel.fromJson(Map<String, dynamic> json) {
    return BookItemModel(
        json['bookId'].toString() ?? '',
        json['title'] ?? '',
        json['brandId'] != null
            ? List<String>.from(json['brandId'].map((id) => id.toString()))
            : [],
        json['price'].toString() ?? '',
        json['quantity'].toString() ?? '',
        json['typeBookId'].toString() ?? '',
        json['description'].toString() ?? '',
        json['ebook'].toString() ?? '',
        json['image'].toString() ?? '',
        json['author_name'] ?? '',
        json['rating'].toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'brandId': brandId.map((id) => id).toList(),
      'price': price,
      'quantity': quantity,
      'typeBookId': typeBookId,
      'description': description,
      'ebook': ebook,
      'image': image,
      'author_name': authorName,
    };
  }
}
