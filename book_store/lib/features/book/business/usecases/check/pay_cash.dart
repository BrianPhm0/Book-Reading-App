// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/check_repository.dart';

class PayCash implements UseCase<void, PayCashParams> {
  final CheckRepository checkRepository;

  PayCash(this.checkRepository);

  @override
  Future<Either<Failure, void>> call(PayCashParams params) async {
    return await checkRepository.payCash(
        params.name, params.phone, params.address, params.voucher);
  }
}

class PayCashParams {
  final String name;
  final String phone;
  final String address;
  final String? voucher;

  PayCashParams(this.name, this.phone, this.address, this.voucher);
}
