part of 'book_bloc.dart';

sealed class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookTypeSuccess extends BookState {
  final List<BookType> bookType;

  const BookTypeSuccess(this.bookType);
}

final class BookItemSuccess extends BookState {
  final List<BookItem> bookItem;

  const BookItemSuccess(this.bookItem);
}

final class BookFailure extends BookState {
  final String? message;
  const BookFailure(this.message);
}

final class LatestBookSuccess extends BookState {
  final List<BookItem> latestBook;

  const LatestBookSuccess(this.latestBook);
}

final class BookItemFail extends BookState {}

final class BooksByTypeSuccess extends BookState {
  final List<Book> booksByType;

  const BooksByTypeSuccess(this.booksByType);
}
