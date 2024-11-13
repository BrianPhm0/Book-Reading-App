// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Voucher extends Equatable {
  final int voucherId;
  final String voucherCode;
  final String releaseDate;
  final String expiredDate;
  final double minCost;
  final double discount;
  const Voucher(
    this.voucherId,
    this.voucherCode,
    this.releaseDate,
    this.expiredDate,
    this.minCost,
    this.discount,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        voucherId,
        voucherCode,
        releaseDate,
        expiredDate,
        minCost,
        discount,
      ];
}
