part of 'address_bloc.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class SaveAddressSuccess extends AddressState {}

final class GetAddressSuccess extends AddressState {
  final List<Address> address;

  const GetAddressSuccess(this.address);
}

final class AddressFail extends AddressState {
  final String? message;

  const AddressFail(this.message);
}
