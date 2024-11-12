part of 'check_bloc.dart';

sealed class CheckState extends Equatable {
  const CheckState();

  @override
  List<Object> get props => [];
}

final class CheckInitial extends CheckState {}

final class CheckLoading extends CheckState {}

final class CheckSuccess extends CheckState {}

final class CheckFailure extends CheckState {
  final String? message;
  const CheckFailure(this.message);
}
