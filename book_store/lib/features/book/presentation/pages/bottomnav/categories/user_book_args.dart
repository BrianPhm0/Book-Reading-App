import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/entities/user.dart';

class UserBookArgs {
  final Book book;
  final User? user;

  UserBookArgs({required this.book, this.user});
}
