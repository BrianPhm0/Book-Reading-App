import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:fpdart/src/either.dart';

class GetPurchaseBook implements UseCase<List<BookItem>, NoParams> {
  final BookRepository bookRepository;

  GetPurchaseBook(this.bookRepository);
  @override
  Future<Either<Failure, List<BookItem>>> call(params) async {
    return await bookRepository.getPurchaseEbook();
  }
}
