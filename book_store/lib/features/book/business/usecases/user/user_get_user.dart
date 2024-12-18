// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';

class GetUser implements UseCase<User, GetUserParams> {
  AuthRepository authRepository;
  GetUser(
    this.authRepository,
  );
  @override
  Future<Either<Failure, User>> call(GetUserParams params) async {
    return await authRepository.getUser();
  }
}

class GetUserParams {}
