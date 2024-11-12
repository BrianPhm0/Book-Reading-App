part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoggedIn extends UserState {
  final User user;

  const UserLoggedIn(this.user);
}

final class UserLoggedInToken extends UserState {
  final String token;

  const UserLoggedInToken(this.token);
}
