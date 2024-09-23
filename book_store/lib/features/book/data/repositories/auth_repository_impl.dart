import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/business/repositories/auth_repository.dart';
import 'package:book_store/features/book/data/datasourses/auth_remote_data_source.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

// Implement method
class AuthRepositoryImpl implements AuthRepository {
  // Call auth remote data source interface to implement
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await remoteDataSource.logInWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      // Handle known exceptions and return a Failure
      return left(Failure(e.message));
    } catch (e) {
      // Handle any other exceptions and return a general Failure
      return left(Failure('Failed to sign up'));
    }
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      // Handle known exceptions and return a Failure
      return left(Failure(e.message));
    } catch (e) {
      // Handle any other exceptions and return a general Failure
      return left(Failure('Failed to login'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await remoteDataSource.resetPassword(email: email);
      return right(null);
    } on ServerException catch (e) {
      // Handle known exceptions and return a Failure
      return left(Failure(e.message));
    } catch (e) {
      // Handle any other exceptions and return a general Failure
      return left(Failure('Check your email again'));
    }
  }
}
