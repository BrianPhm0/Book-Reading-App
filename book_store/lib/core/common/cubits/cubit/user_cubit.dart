import 'package:bloc/bloc.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(UserInitial());
    } else {
      emit(UserLoggedIn(user));
    }
  }

  void updateToken(String? token) {
    if (token == null) {
      emit(UserInitial());
    } else {
      emit(UserLoggedInToken(token));
    }
  }
}
