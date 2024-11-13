// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/repositories/order_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/order_data.dart';
import 'package:book_store/features/book/data/model/order/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderData orderData;
  OrderRepositoryImpl(
    this.orderData,
  );

  @override
  Future<Either<Failure, Map<String, List<OrderItem>>>> getOrder() async {
    try {
      final getOrder = await orderData.getOrder();

      return right(getOrder);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
