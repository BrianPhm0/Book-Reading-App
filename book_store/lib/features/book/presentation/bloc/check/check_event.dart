part of 'check_bloc.dart';

sealed class CheckEvent extends Equatable {
  const CheckEvent();

  @override
  List<Object> get props => [];
}

final class ResetCheckEvent extends CheckEvent {}

final class PayCashEvent extends CheckEvent {
  final String name;
  final String phone;
  final String address;
  final String voucher;

  const PayCashEvent(this.name, this.phone, this.address, this.voucher);
}
