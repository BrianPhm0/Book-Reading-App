import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:book_store/features/book/business/repositories/voucher_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/voucher_data.dart';
import 'package:fpdart/src/either.dart';

class VoucherRepositoryImpl implements VoucherRepository {
  final VoucherData voucherData;

  VoucherRepositoryImpl(this.voucherData);

  @override
  Future<Either<Failure, List<Voucher>>> getVoucher() async {
    try {
      final voucher = await voucherData.getVoucherUser();
      return right(voucher);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addVoucher(String id) async {
    try {
      await voucherData.addVoucher(id);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Voucher>>> getPublicVoucher() async {
    try {
      final voucher = await voucherData.getPublicVoucher();
      return right(voucher);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
