import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/business/entities/user/user.dart';

class UserBookArgs {
  final BookItem book;
  final User? user;
  final String? brandName;

  UserBookArgs({required this.book, this.user, this.brandName});
}
