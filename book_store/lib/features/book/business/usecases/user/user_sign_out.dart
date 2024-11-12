// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';

class UserSignOut implements UseCase<void, UserSignOutParams> {
  AuthRepository authRepository;
  UserSignOut(
    this.authRepository,
  );

  @override
  Future<Either<Failure, void>> call(UserSignOutParams params) async {
    return await authRepository.signOut();
  }
}

class UserSignOutParams {}
