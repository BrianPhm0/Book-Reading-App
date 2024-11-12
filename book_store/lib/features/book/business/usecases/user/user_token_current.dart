import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserTokenCurrent implements UseCase<String, NoTokenParams> {
  final AuthRepository authRepository;

  UserTokenCurrent(this.authRepository);
  @override
  Future<Either<Failure, String>> call(NoTokenParams params) async {
    return await authRepository.getToken();
  }
}

class NoTokenParams {}
