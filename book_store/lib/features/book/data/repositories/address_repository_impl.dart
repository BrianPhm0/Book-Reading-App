// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/address/address.dart';
import 'package:book_store/features/book/business/repositories/address_repository.dart';
import 'package:book_store/features/book/data/datasourses/local/local_data.dart';

class AddressRepositoryImpl implements AddressRepository {
  final LocalData localData;

  AddressRepositoryImpl({
    required this.localData,
  });

  @override
  Future<Either<Failure, List<Address>>> getAddress() async {
    try {
      final addresses = await localData.getAddress();
      return right(addresses);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveAddress(
      String name, String phone, String address) async {
    try {
      await localData.saveAddress(name, phone, address);
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
