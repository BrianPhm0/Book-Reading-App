import 'package:book_store/core/error/failure.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:book_store/features/book/data/model/order/order_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OrderRepository {
  Future<Either<Failure, Map<String, List<OrderItem>>>> getOrder();
}
