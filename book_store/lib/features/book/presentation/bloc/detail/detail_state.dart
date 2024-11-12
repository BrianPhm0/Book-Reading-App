part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailFailure extends DetailState {
  final String? message;
  const DetailFailure(this.message);
}

final class DetailSuccess extends DetailState {
  final BookItem detailBook;
  final List<Review> review;

  const DetailSuccess(this.detailBook, this.review);
}
