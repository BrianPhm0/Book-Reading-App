part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

final class GetAllBookType extends BookEvent {}

final class GetBooksByType extends BookEvent {
  final int bookIdType;

  const GetBooksByType(this.bookIdType);
}

final class ResetBooksState extends BookEvent {}
