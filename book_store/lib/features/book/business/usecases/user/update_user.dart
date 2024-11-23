import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateUser implements UseCase<void, UpdateUserParams> {
  final AuthRepository authRepository;

  UpdateUser(this.authRepository);

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) async {
    return await authRepository.updateUser(params.id, params.name, params.email,
        params.phone, params.fullName, params.address);
  }
}

class UpdateUserParams {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String fullName;
  final String address;

  UpdateUserParams(
      this.id, this.name, this.email, this.phone, this.fullName, this.address);
}
