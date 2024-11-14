part of 'detail_bloc.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

final class GetDetailEvent extends DetailEvent {
  final String id;

  const GetDetailEvent(this.id);
}

final class PostReviewEvent extends DetailEvent {
  final String id;
  final String rating;
  final String comment;

  const PostReviewEvent(this.id, this.rating, this.comment);
}
