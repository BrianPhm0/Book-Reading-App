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

final class BookFailure extends BookState {
  final String? message;
  const BookFailure(this.message);
}

final class BooksByTypeSuccess extends BookState {
  final List<Book> booksByType;

  const BooksByTypeSuccess(this.booksByType);
}
