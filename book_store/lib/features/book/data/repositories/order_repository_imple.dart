// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/repositories/order_repository.dart';
import 'package:book_store/features/book/data/datasourses/remote/order_data.dart';

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

  @override
  Future<Either<Failure, List<OrderId>>> getOrderById(String id) async {
    try {
      final getOrderId = await orderData.getOrderById(id);

      return right(getOrderId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> cancelOrder(String id) async {
    try {
      final getOrderId = await orderData.cancelOrder(id);
      return right(getOrderId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  
}
