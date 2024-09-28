import 'package:book_store/features/book/business/entities/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel extends Book {
  const BookModel(
      super.bookId,
      super.title,
      super.image,
      super.bookTypeId,
      super.uploadDate,
      super.price,
      super.quantity,
      super.description,
      super.rating);

  factory BookModel.fromJson(Map<String, dynamic> map) {
    return BookModel(
      map['bookId'] ?? '', // Handle missing bookId
      map['title'] ?? '', // Handle missing title
      map['image'] ?? '', // Handle missing image
      map['bookTypeId'] ?? 0, // Provide default for bookTypeId
      (map['uploadDate'] as Timestamp?)?.toDate() ??
          DateTime.now(), // Convert Timestamp to DateTime
      map['price']?.toDouble() ?? 0.0, // Ensure price is double
      map['quantity'] ?? 0, // Default quantity
      map['description'] ?? '', // Default description
      map['rating']?.toDouble() ?? 0.0, // Ensure rating is double
    );
  }
}
