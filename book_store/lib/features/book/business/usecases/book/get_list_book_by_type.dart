import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:fpdart/src/either.dart';

class GetListBooksByType implements UseCase<List<BookItem>, BooksByTypeParam> {
  final BookRepository bookRepository;

  GetListBooksByType(this.bookRepository);
  @override
  Future<Either<Failure, List<BookItem>>> call(BooksByTypeParam param) async {
    return await bookRepository.getBooksByTypes(bookTypeId: param.bookTypeId);
  }
}

class BooksByTypeParam {
  final int bookTypeId;

  BooksByTypeParam(this.bookTypeId);
}
