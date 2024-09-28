// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/business/usecases/user_current.dart';
import 'package:book_store/features/book/business/usecases/user_forget_pass.dart';
import 'package:book_store/features/book/business/usecases/user_login.dart';
import 'package:book_store/features/book/business/usecases/user_sign_out.dart';
import 'package:book_store/features/book/business/usecases/user_sign_up.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

//manages the authentication logic by reacting to AuthEvent and emitting AuthState update
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserForgetPass _userForgetPass;
  final UserSignOut _userSignOut;
  final CurrentUser _currentUser;
  final UserCubit _userCubit;
  //handle the use case
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required UserForgetPass userForgetPass,
    required UserSignOut userSignOut,
    required CurrentUser currentUser,
    required UserCubit userCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userForgetPass = userForgetPass,
        _userSignOut = userSignOut,
        _currentUser = currentUser,
        _userCubit = userCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthResetPass>(_onAuthResetPass);
    on<AuthIsUserLoggedIn>(_onAuthCurrentUser);
    on<AuthUserSignOut>(_onUserSignOut);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    //store the result of sign up state
    //fold handle both the failure and the success cases
    final res = await _userSignUp(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    //store the result of sign up state
    //fold handle both the failure and the success cases
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (r) => _emitAuthSuccess(r, emit));
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

  void _onAuthCurrentUser(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(const AuthFailure()), (r) {
      _emitAuthSuccess(r, emit);
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _userCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _onUserSignOut(AuthUserSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignOut(UserSignOutParams());
    res.fold((l) => emit(AuthFailure(l.message)), (r) {
      _userCubit.updateUser(null);
      emit(AuthSignOutSuccess());
    });
  }
}
