import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, Map<String, List<OrderItem>>>> getOrder();

  Future<Either<Failure, List<OrderId>>> getOrderById(String id);

  Future<Either<Failure, void>> cancelOrder(String id);
  
}
