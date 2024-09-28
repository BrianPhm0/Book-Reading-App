import 'package:equatable/equatable.dart';

class BookType extends Equatable {
  final int bookTypeId;
  final String bookTypeName;

  const BookType(this.bookTypeId, this.bookTypeName);

  @override
  // TODO: implement props
  List<Object?> get props => [bookTypeId, bookTypeName];
}
