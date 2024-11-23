import 'package:equatable/equatable.dart';

// Lớp BookItem cơ sở
class BookItem extends Equatable {
  final String bookId;
  final String title;
  final List<String>? brandId;
  final String? price;
  final String? linkEbook;
  final String? uploadDate;
  final String? quantity;
  final String? typeBookId;
  final String image;
  final String? rating;
  final String? description;
  final String authorName;

  final List<String>? brandNames;

  const BookItem(
    this.bookId,
    this.title,
    this.brandId,
    this.price,
    this.linkEbook,
    this.uploadDate,
    this.quantity,
    this.typeBookId,
    this.image,
    this.rating,
    this.description,
    this.authorName,
    this.brandNames,
  );

  // final String uploadDate;

  @override
  List<Object?> get props => [
        bookId,
        title,
        brandId,
        price,
        linkEbook,
        uploadDate,
        quantity,
        typeBookId,
        image,
        rating,
        description,
        authorName,
        brandNames,
      ];
}
