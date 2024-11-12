import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/repositories/home_repository.dart';
import 'package:fpdart/src/either.dart';

class TopBook implements UseCase<List<BookItem>, NoParams> {
  final HomeRepository homeRepository;

  TopBook(this.homeRepository);
  @override
  Future<Either<Failure, List<BookItem>>> call(params) async {
    return await homeRepository.getTopBook();
  }
}
