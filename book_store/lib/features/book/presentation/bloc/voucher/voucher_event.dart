part of 'voucher_bloc.dart';

sealed class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object> get props => [];
}

final class GetVoucherEvent extends VoucherEvent {}

final class GetPublicVoucherEvent extends VoucherEvent {}

final class AddVoucherEvent extends VoucherEvent {
  final String id;

  const AddVoucherEvent(this.id);
}
