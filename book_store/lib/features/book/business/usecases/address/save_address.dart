import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/address_repository.dart';
import 'package:fpdart/src/either.dart';

class SaveAddress implements UseCase<void, SaveAddressParams> {
  final AddressRepository addressRepository;

  SaveAddress(this.addressRepository);

  @override
  Future<Either<Failure, void>> call(SaveAddressParams params) async {
    return await addressRepository.saveAddress(
        params.name, params.phone, params.address);
  }
}

class SaveAddressParams {
  final String name, phone, address;

  SaveAddressParams(this.name, this.phone, this.address);
}
