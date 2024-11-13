import 'package:book_store/features/book/business/entities/voucher/voucher.dart';

class VoucherModel extends Voucher {
  const VoucherModel(super.voucherId, super.voucherCode, super.releaseDate,
      super.expiredDate, super.minCost, super.discount);

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    DateTime releaseDateTime = DateTime.parse(json['releaseDate']);
    DateTime expiredDateTime = DateTime.parse(json['expiredDate']);

    return VoucherModel(
      json['voucherId'],
      json['voucherCode'],
      '${releaseDateTime.day}-${releaseDateTime.month}-${releaseDateTime.year}',
      '${expiredDateTime.day}-${expiredDateTime.month}-${expiredDateTime.year}',
      json['minCost'].toDouble(),
      json['discount'].toDouble(),
    );
  }
}
