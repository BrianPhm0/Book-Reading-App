// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';

import 'package:book_store/features/book/business/repositories/voucher_repository.dart';

class AddVoucher implements UseCase<void, AddVoucherParams> {
  final VoucherRepository voucherRepository;

  AddVoucher(this.voucherRepository);

  @override
  Future<Either<Failure, void>> call(AddVoucherParams params) async {
    return await voucherRepository.addVoucher(params.id);
  }
}

class AddVoucherParams {
  String id;
  AddVoucherParams(
    this.id,
  );
}
