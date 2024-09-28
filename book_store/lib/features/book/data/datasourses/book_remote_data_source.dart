import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/data/model/book_model.dart';

import 'package:book_store/features/book/data/model/book_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class BookRemoteDataSource {
  Future<List<BookTypeModel>> getAllBookTypes();
  Future<List<BookModel>> getBooksByType(int bookTypeId);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final FirebaseFirestore firebaseBook;

  BookRemoteDataSourceImpl(this.firebaseBook);

  @override
  Future<List<BookTypeModel>> getAllBookTypes() async {
    try {
      QuerySnapshot querySnapshot =
          await firebaseBook.collection('book_types').get();
      List<BookTypeModel> bookTypes = querySnapshot.docs.map((doc) {
        return BookTypeModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      // Logging the fetched book type
      return bookTypes;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BookModel>> getBooksByType(int bookTypeId) async {
    try {
      QuerySnapshot querySnapshot = await firebaseBook
          .collection('books')
          .where('bookTypeId', isEqualTo: bookTypeId)
          .get();

      List<BookModel> getBookTypes = querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return getBookTypes;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
