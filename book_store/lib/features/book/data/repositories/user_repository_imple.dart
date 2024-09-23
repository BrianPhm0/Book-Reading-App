import 'package:book_store/features/book/business/repositories/user_repository.dart';
import 'package:book_store/features/book/data/datasourses/data_state.dart';
import 'package:book_store/features/book/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserRepositoryImple implements UserRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  UserRepositoryImple({required this.firebaseAuth});

  @override
  Future<DataState<List<UserModel>>> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception('Failed to sign up');
    }
  }
}
