import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/address/address.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AddressRepository {
  Future<Either<Failure, void>> saveAddress(
      String name, String phone, String address);
  Future<Either<Failure, List<Address>>> getAddress();
}
