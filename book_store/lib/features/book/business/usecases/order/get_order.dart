import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/order/order_item.dart';
import 'package:book_store/features/book/business/repositories/order_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetOrder implements UseCase<Map<String, List<OrderItem>>, NoParams> {
  final OrderRepository orderRepository;

  GetOrder(this.orderRepository);
  @override
  Future<Either<Failure, Map<String, List<OrderItem>>>> call(params) async {
    return await orderRepository.getOrder();
  }
}
