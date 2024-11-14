part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

final class ResetBooksState extends BookEvent {}

final class GetAllBookType extends BookEvent {}

final class GetBooksByType extends BookEvent {
  final int bookIdType;

  const GetBooksByType(this.bookIdType);
}

final class GetItemBook extends BookEvent {
  final int bookIdType;

  const GetItemBook(this.bookIdType);
}

final class GetPurchaseBookEvent extends BookEvent {}

final class GetLatestBookEvent extends BookEvent {}

final class SearchBookEvent extends BookEvent {
  final String? name;
  final String? pageNumber;
  final String? pageSize;

  const SearchBookEvent(this.name, this.pageNumber, this.pageSize);
}
