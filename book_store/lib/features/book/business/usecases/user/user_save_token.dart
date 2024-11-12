// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:fpdart/src/either.dart';

// import 'package:book_store/core/error/failure.dart';
// import 'package:book_store/core/usecase/usercase.dart';
// import 'package:book_store/features/book/business/repositories/remote/auth_repository.dart';

// class UserSaveToken implements UseCase<void, UserSaveTokenParams> {
//   final AuthRepository authRepository;
//   UserSaveToken(
//     this.authRepository,
//   );A

//   @override
//   Future<Either<Failure, void>> call(UserSaveTokenParams params) async {
//     try {
//       await authRepository.saveToken(params.token);
//       return const Right(null); // Indicate success with Right(void)
//     } catch (e) {
//       return Left(
//           Failure("Failed to save token")); // Or a specific failure type
//     }
//   }
// }

// class UserSaveTokenParams {
//   final String token;

//   UserSaveTokenParams({required this.token});
// }
