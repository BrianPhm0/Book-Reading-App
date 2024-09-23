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

final class AuthResetPass extends AuthEvent {
  final String email;
  const AuthResetPass({required this.email});
}
