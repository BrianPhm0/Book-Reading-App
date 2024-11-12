part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

final class SaveAddressEvent extends AddressEvent {
  final String name, phone, address;

  const SaveAddressEvent(this.name, this.phone, this.address);
}

final class GetAddressEvent extends AddressEvent {}
