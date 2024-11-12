import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/address/address.dart';
import 'package:book_store/features/book/business/repositories/address_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAddress implements UseCase<List<Address>, NoParams> {
  final AddressRepository addressRepository;

  GetAddress(this.addressRepository);

  @override
  Future<Either<Failure, List<Address>>> call(NoParams params) async {
    return await addressRepository.getAddress();
  }
}
