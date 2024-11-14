import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/order_repository.dart';
import 'package:fpdart/src/either.dart';

class CancelOrder implements UseCase<void, CancelOrderParams> {
  final OrderRepository orderRepository;

  CancelOrder(this.orderRepository);
  @override
  Future<Either<Failure, void>> call(CancelOrderParams params) async {
    return await orderRepository.cancelOrder(params.id);
  }
}

class CancelOrderParams {
  final String id;

  CancelOrderParams(this.id);
}
