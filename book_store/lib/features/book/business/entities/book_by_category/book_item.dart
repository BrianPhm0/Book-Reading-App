import 'package:equatable/equatable.dart';

// Lớp BookItem cơ sở
class BookItem extends Equatable {
  final String bookId;
  final String title;
  final List<String> brandId;
  final String price;
  final String quantity;
  final String typeBookId;
  final String description;
  final String ebook;
  final String image;
  final String authorName;
  final String rating;

  const BookItem(
    this.bookId,
    this.title,
    this.brandId,
    this.price,
    this.quantity,
    this.typeBookId,
    this.description,
    this.ebook,
    this.image,
    this.authorName,
    this.rating,
  );

  @override
  List<Object?> get props => [
        bookId,
        title,
        brandId,
        price,
        quantity,
        typeBookId,
        description,
        ebook,
        image,
        authorName,
        rating
      ];
}
