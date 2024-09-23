// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/business/usecases/user_forget_pass.dart';
import 'package:book_store/features/book/business/usecases/user_login.dart';
import 'package:book_store/features/book/business/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

//manages the authentication logic by reacting to AuthEvent and emitting AuthState update
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserForgetPass _userForgetPass;
  //handle the use case
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required UserForgetPass userForgetPass,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userForgetPass = userForgetPass,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthResetPass>(_onAuthResetPass);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    //store the result of sign up state
    //fold handle both the failure and the success cases
    final res = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    //store the result of sign up state
    //fold handle both the failure and the success cases
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _onAuthResetPass(AuthResetPass event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userForgetPass(UserForgetPassParams(email: event.email));
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(
          AuthPasswordResetSuccess()), // Emit a specific state for password reset
    );
  }
}
