import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class VoucherRepository {
  Future<Either<Failure, List<Voucher>>> getVoucher();
  Future<Either<Failure, List<Voucher>>> getPublicVoucher();
  Future<Either<Failure, void>> addVoucher(String id);
}
