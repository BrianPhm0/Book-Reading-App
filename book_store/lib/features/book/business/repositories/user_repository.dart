import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/data/datasourses/data_state.dart';

abstract class UserRepository {
  Future<DataState<List<User>>> getUser();
  Future<void> signUp(String email, String password);
}
