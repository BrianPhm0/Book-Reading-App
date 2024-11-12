import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
// Ensure the import is correct for UseCase
// import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserForgetPass implements UseCase<void, UserForgetPassParams> {
  final AuthRepository authRepository;

  UserForgetPass(this.authRepository);

  @override
  Future<Either<Failure, void>> call(UserForgetPassParams params) async {
    return await authRepository.resetPassword(email: params.email);
  }
}

class UserForgetPassParams {
  final String email;

  UserForgetPassParams({required this.email});
}
