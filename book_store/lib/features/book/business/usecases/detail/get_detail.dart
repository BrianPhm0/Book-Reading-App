import 'package:book_store/core/error/failure.dart';
import 'package:book_store/core/usecase/usercase.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/data/repositories/detail_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetDetail implements UseCase<BookItem, DetailParams> {
  final DetailRepository detailRepository;

  GetDetail(this.detailRepository);

  @override
  Future<Either<Failure, BookItem>> call(DetailParams params) async {
    return await detailRepository.getDetail(params.id);
  }
}

class DetailParams {
  final String id;

  DetailParams({required this.id});
}
