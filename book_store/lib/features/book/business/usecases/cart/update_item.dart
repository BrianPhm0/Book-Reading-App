import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateItem implements UseCase<String, UpdateItemParams> {
  final CartRepository cartRepository;

  UpdateItem(this.cartRepository);

  @override
  Future<Either<Failure, String>> call(UpdateItemParams params) async {
    return await cartRepository.updateItem(params.id, params.quantity);
  }
}

class UpdateItemParams {
  final String id;
  final int quantity;

  UpdateItemParams({required this.id, required this.quantity});
}
