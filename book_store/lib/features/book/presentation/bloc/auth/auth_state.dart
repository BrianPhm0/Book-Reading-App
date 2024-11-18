part of 'auth_bloc.dart';

//defines the possible states that the authentication process can be in

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

//create a loding indicator
final class AuthLoading extends AuthState {}

//auth success
final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}

//auth failure
final class AuthFailure extends AuthState {
  final String? message;
  const AuthFailure([this.message]);
}

final class AuthTokenSuccess extends AuthState {
  final String token;
  const AuthTokenSuccess(this.token);
}

// New state for successful password reset
final class AuthPasswordResetSuccess extends AuthState {}

final class AuthSignOutSuccess extends AuthState {}

final class UpdateUserSuccess extends AuthState {}

final class VerifyCodeSuccess extends AuthState {
  final String? verifyCode;

  const VerifyCodeSuccess(this.verifyCode);
}
// final class AuthCurrUser extends AuthState {}
