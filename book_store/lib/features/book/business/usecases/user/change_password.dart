

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';

import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangePassword implements UseCase<void, ChangePasswordParams> {
  final AuthRepository authRepository;

  ChangePassword(this.authRepository);
  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await authRepository.changePassword(params.oldPass, params.newPass);
  }
}

class ChangePasswordParams {
  final String oldPass;
  final String newPass;

  ChangePasswordParams(this.oldPass, this.newPass);
}
