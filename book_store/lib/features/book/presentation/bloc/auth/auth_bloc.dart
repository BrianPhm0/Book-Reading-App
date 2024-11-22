// ignore: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';
import 'package:book_store/features/book/business/usecases/user/update_user.dart';
import 'package:book_store/features/book/business/usecases/user/user_current.dart';
import 'package:book_store/features/book/business/usecases/user/user_forget_pass.dart';
import 'package:book_store/features/book/business/usecases/user/user_get_user.dart';
import 'package:book_store/features/book/business/usecases/user/user_login.dart';
import 'package:book_store/features/book/business/usecases/user/user_login_jwt.dart';
import 'package:book_store/features/book/business/usecases/user/user_sign_out.dart';
import 'package:book_store/features/book/business/usecases/user/user_sign_up.dart';
import 'package:book_store/features/book/business/usecases/user/user_token_current.dart';
import 'package:book_store/features/book/business/usecases/user/verify.dart';
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
  final UserLoginJwt _userLoginJwt;
  final UserTokenCurrent _tokenCurrent;
  final GetUser _getUser;
  final VerifyCode _verifyCode;
  final UpdateUser _updateUser;
  //handle the use case
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required UserForgetPass userForgetPass,
      required UserSignOut userSignOut,
      required CurrentUser currentUser,
      required UserCubit userCubit,
      required UserTokenCurrent tokenCurrent,
      required GetUser getUser,
      required UpdateUser updateUser,
      required VerifyCode verifyCode,
      required UserLoginJwt userLoginJwt})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _userForgetPass = userForgetPass,
        _userSignOut = userSignOut,
        _currentUser = currentUser,
        _userCubit = userCubit,
        _userLoginJwt = userLoginJwt,
        _tokenCurrent = tokenCurrent,
        _verifyCode = verifyCode,
        _updateUser = updateUser,
        _getUser = getUser,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthResetPass>(_onAuthResetPass);
    on<AuthIsUserLoggedIn>(_onAuthCurrentUser);
    on<AuthUserSignOut>(_onUserSignOut);
    on<AuthIsTokendIn>(_onAuthTokenUser);
    on<AuthLoginToken>(_onUserLoginJwt);
    on<AuthGetUser>(_onAuthGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<VerifyCodeEvent>(_onVerifyCode);
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

  void _onAuthTokenUser(AuthIsTokendIn event, Emitter<AuthState> emit) async {
    final res = await _tokenCurrent(NoTokenParams());
    res.fold((l) => emit(const AuthFailure()), (r) {
      _userCubit.updateToken(r);
      emit(AuthTokenSuccess(r));
    });
  }

  void _onAuthGetUser(AuthGetUser event, Emitter<AuthState> emit) async {
    final res = await _getUser(GetUserParams());
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

  void _onUserLoginJwt(AuthLoginToken event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLoginJwt(
        UserLoginJwtParams(name: event.name, password: event.password));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (r) => emit(AuthTokenSuccess(r)));
  }

  void _onUpdateUser(UpdateUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _updateUser(UpdateUserParams(
        event.id, event.email, event.phone, event.fullName, event.address));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (r) => emit(UpdateUserSuccess()));
  }

  void _onVerifyCode(VerifyCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _verifyCode(VerifyParams(email: event.code));
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (r) => emit(VerifyCodeSuccess(r)));
  }
}
