import 'package:equatable/equatable.dart';

// Lớp BookItem cơ sở
class BookItem extends Equatable {
  final String bookId;
  final String title;
  final List<String>? brandId;
  final String? price;
  final String? uploadDate;
  final String? quantity;
  final String? typeBookId;
  final String image;
  final String? rating;
  final String? description;
  final String authorName;
  final String author;
  final List<String>? brandNames;

  const BookItem(
      this.bookId,
      this.title,
      this.brandId,
      this.price,
      this.uploadDate,
      this.quantity,
      this.typeBookId,
      this.image,
      this.rating,
      this.description,
      this.authorName,
      this.brandNames,
      this.author);

  // final String uploadDate;

  @override
  List<Object?> get props => [
        bookId,
        title,
        brandId,
        price,
        uploadDate,
        quantity,
        typeBookId,
        image,
        rating,
        description,
        authorName,
        author,
        brandNames,
      ];
}
