part of 'auth_bloc.dart';

//not subclass outside its file
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//represents the event for user sign-up
//this event will trigger the logic inside the AuthBloc for handling user sign-ups
final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthSignUp(
      {required this.email, required this.password, required this.name});
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});
}

final class AuthLoginToken extends AuthEvent {
  final String name;
  final String password;

  const AuthLoginToken({required this.name, required this.password});
}

final class AuthGetUser extends AuthEvent {}

final class AuthResetPass extends AuthEvent {
  final String email;
  const AuthResetPass({required this.email});
}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthIsTokendIn extends AuthEvent {}

final class AuthUserSignOut extends AuthEvent {}

final class UpdateUserEvent extends AuthEvent {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String fullName;
  final String address;

  const UpdateUserEvent(
      this.id, this.name, this.email, this.phone, this.fullName, this.address);
}

final class VerifyCodeEvent extends AuthEvent {
  final String code;

  const VerifyCodeEvent(this.code);
}

final class ChangePassEvent extends AuthEvent {
  final String oldPass;
  final String newPass;

  const ChangePassEvent(this.oldPass, this.newPass);
}
