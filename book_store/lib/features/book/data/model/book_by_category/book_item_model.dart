import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';

class BookItemModel extends BookItem {
  const BookItemModel(
      super.bookId,
      super.title,
      super.brandId,
      super.price,
      super.uploadDate,
      super.quantity,
      super.typeBookId,
      super.image,
      super.rating,
      super.description,
      super.authorName,
      super.brandNames,
      super.author);

  factory BookItemModel.fromJson(Map<String, dynamic> json) {
    return BookItemModel(
      json['bookId']?.toString() ?? '',
      json['title'] ?? '',
      json['brandId'] != null
          ? List<String>.from(json['brandId'].map((id) => id.toString()))
          : null,
      json['price']?.toString(),
      json['uploadDate'] != null
          ? DateTime.parse(json['uploadDate']).toString()
          : null,
      json['quantity']?.toString(),
      json['typeBookId']?.toString(),
      json['image']?.toString() ?? '',
      json['rating']?.toString() ?? '0',
      json['description']?.toString(),
      json['author_name'] ?? '',
      json['brandNames'] != null ? List<String>.from(json['brandNames']) : null,
      json['authorName'] ?? '',
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'bookId': bookId,
  //     'title': title,
  //     'brandId': brandId.map((id) => id).toList(),
  //     'price': price,
  //     'quantity': quantity,
  //     'typeBookId': typeBookId,
  //     'description': description,
  //     'image': image,
  //     'author_name': authorName,
  //   };
  // }
}
