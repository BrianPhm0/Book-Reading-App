import 'package:book_store/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

/*interface of usecase, enforce a structure for how usecase are implement,
/ ensuring they follow a consistent pattern
failure and success, set of parameters*/
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
