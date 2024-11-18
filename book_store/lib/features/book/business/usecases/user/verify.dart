import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class VerifyCode implements UseCase<String?, VerifyParams> {
  AuthRepository authRepository;
  VerifyCode(
    this.authRepository,
  );
  @override
  Future<Either<Failure, String?>> call(VerifyParams params) async {
    return await authRepository.verifyCode(email: params.email);
  }
}

class VerifyParams {
  final String email;

  VerifyParams({required this.email});
}
