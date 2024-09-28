import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:book_store/features/book/data/model/book_model.dart';
import 'package:fpdart/src/either.dart';

class GetListBooksByType implements UseCase<List<Book>, BooksByTypeParam> {
  final BookRepository bookRepository;

  GetListBooksByType(this.bookRepository);
  @override
  Future<Either<Failure, List<Book>>> call(BooksByTypeParam param) async {
    return await bookRepository.getBooksByTypes(bookTypeId: param.bookTypeId);
  }
}

class BooksByTypeParam {
  final int bookTypeId;

  BooksByTypeParam(this.bookTypeId);
}
