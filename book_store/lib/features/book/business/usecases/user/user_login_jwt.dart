// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';

class UserLoginJwt implements UseCase<String, UserLoginJwtParams> {
  AuthRepository authRepository;
  UserLoginJwt(
    this.authRepository,
  );
  @override
  Future<Either<Failure, String>> call(UserLoginJwtParams params) async {
    return await authRepository.logInWithNamePassword(
        name: params.name, password: params.password);
  }
}

class UserLoginJwtParams {
  final String name;
  final String password;

  UserLoginJwtParams({required this.name, required this.password});
}
