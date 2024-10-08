import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:fpdart/fpdart.dart';

//define abstract method
abstract interface class AuthRepository {
  //failure and sucess
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  Future<Either<Failure, void>> signOut();
}
