// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_store/features/book/business/entities/book_type.dart';
import 'package:fpdart/src/either.dart';

import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/repositories/book_repository.dart';

class GetListBookTypeUsecase
    implements UseCase<List<BookType>, GetListBookTypeParams> {
  BookRepository bookRepository;
  GetListBookTypeUsecase(
    this.bookRepository,
  );
  @override
  Future<Either<Failure, List<BookType>>> call(params) async {
    return await bookRepository.getAllBookTypes();
  }
}

class GetListBookTypeParams {}
