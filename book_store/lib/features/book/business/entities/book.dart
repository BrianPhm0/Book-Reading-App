import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String bookId;
  final String title;
  final String image;
  final int bookTypeId;
  final DateTime uploadDate;
  final double price;
  final int quantity;
  final String description;
  final double rating;

  const Book(
      this.bookId,
      this.title,
      this.image,
      this.bookTypeId,
      this.uploadDate,
      this.price,
      this.quantity,
      this.description,
      this.rating);

  @override
  // TODO: implement props
  List<Object?> get props => [
        bookId,
        title,
        image,
        bookTypeId,
        uploadDate,
        price,
        quantity,
        description,
        rating
      ];
}
