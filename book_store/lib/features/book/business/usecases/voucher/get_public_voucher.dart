import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/voucher/voucher.dart';
import 'package:book_store/features/book/business/repositories/voucher_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPublicVoucher implements UseCase<List<Voucher>, NoParams> {
  final VoucherRepository voucherRepository;

  GetPublicVoucher(this.voucherRepository);

  @override
  Future<Either<Failure, List<Voucher>>> call(params) async {
    return await voucherRepository.getPublicVoucher();
  }
}
