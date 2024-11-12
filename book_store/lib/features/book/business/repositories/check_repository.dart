import 'package:book_store/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CheckRepository  {
  Future<Either<Failure, void>> payCash(
      String name, String phone, String address, String? voucher);
}
