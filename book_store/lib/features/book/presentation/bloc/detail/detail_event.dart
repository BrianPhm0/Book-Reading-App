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
