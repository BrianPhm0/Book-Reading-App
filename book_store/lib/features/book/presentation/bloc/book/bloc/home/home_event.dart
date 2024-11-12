part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class ResetHomeState extends HomeEvent {}

final class GetHomeBookEvent extends HomeEvent {}