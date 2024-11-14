import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/order/order_id.dart';
import 'package:book_store/features/book/business/repositories/order_repository.dart';
import 'package:fpdart/src/either.dart';

class GetOrderById implements UseCase<List<OrderId>, GetOrderIdParams> {
  final OrderRepository orderRepository;

  GetOrderById(this.orderRepository);
  @override
  Future<Either<Failure, List<OrderId>>> call(GetOrderIdParams params) async {
    return await orderRepository.getOrderById(params.id);
  }
}

class GetOrderIdParams {
  final String id;

  GetOrderIdParams(this.id);
}
