// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/repositories/check_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/check_data.dart';

class CheckRepositoryImpl implements CheckRepository {
  CheckData checkData;
  CheckRepositoryImpl(
    this.checkData,
  );
  @override
  Future<Either<Failure, void>> payCash(
      String name, String phone, String address, String? voucher) async {
    try {
      await checkData.payCash(name, phone, address, voucher);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
