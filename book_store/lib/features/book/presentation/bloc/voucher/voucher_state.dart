part of 'voucher_bloc.dart';

sealed class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
}

final class VoucherInitial extends VoucherState {}

final class VoucherLoading extends VoucherState {}

final class VoucherFailure extends VoucherState {
  final String? message;
  const VoucherFailure(this.message);
}

final class GetVoucherSuccess extends VoucherState {
  final List<Voucher> voucher;

  const GetVoucherSuccess(this.voucher);
}

final class GetPublicVoucherSuccess extends VoucherState {
  final List<Voucher> voucher;

  const GetPublicVoucherSuccess(this.voucher);
}

final class AddVoucherSuccess extends VoucherState {}
