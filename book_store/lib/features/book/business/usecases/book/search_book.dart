import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchBook implements UseCase<List<BookItem>, SearchBookParams> {
  final BookRepository bookRepository;

  SearchBook(this.bookRepository);
  @override
  Future<Either<Failure, List<BookItem>>> call(SearchBookParams params) async {
    return await bookRepository.searchEbook(
        params.name, params.pageNumber, params.pageSize);
  }
}

class SearchBookParams {
  final String? name;
  final String? pageNumber;
  final String? pageSize;

  SearchBookParams(this.name, this.pageNumber, this.pageSize);
}
