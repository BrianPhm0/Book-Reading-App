part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<BookItem> topBooks;
  final List<BookItem> latestBooks;
  final List<BookItem> bestDeal;

  const HomeSuccess(
      {required this.topBooks,
      required this.latestBooks,
      required this.bestDeal});
}

final class HomeFailure extends HomeState {
  final String? message;
  const HomeFailure(this.message);
}
