//Data remote firebase

import 'package:book_store/core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:book_store/features/book/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract interface class AuthRemoteDataSource {
  final firebase_auth.User? firebaseUser;

  AuthRemoteDataSource(this.firebaseUser);

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData();

  Future<void> resetPassword({required String email});
}

//implement
class AuthRemoteDataSourceImple implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImple(this.firebaseAuth);
  @override
  firebase_auth.User? get firebaseUser => firebaseAuth.currentUser;

  @override
  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final firebase_auth.User? firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw const ServerException('User is null');
      }

      return UserModel(
        firebaseUser.uid,
        firebaseUser.displayName,
        '', // Do not store the password in plain text
        firebaseUser.email ?? '',
        firebaseUser.phoneNumber ?? '',
        '', // Address if available
        'user', // Example role
        firebaseUser.photoURL ?? '',
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw const ServerException('No user found for that email.');
        case 'wrong-password':
          throw const ServerException('Wrong password provided for that user.');
        default:
          throw const ServerException('An unknown error occurred.');
      }
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final firebase_auth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw const ServerException('User is null');
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set({
        'name': name,
        'email': firebaseUser.email ?? '',
        'phoneNumber': firebaseUser.phoneNumber ?? '',
        'address': '',
        'role': 'user', // Example role
        'photoURL': firebaseUser.photoURL ?? '',
        // Add any other fields you need
      });

      return UserModel(
          firebaseUser.uid,
          name,
          '', // Password should not be stored in plain text
          firebaseUser.email ?? '',
          firebaseUser.phoneNumber ?? '',
          '', // Address if available
          'user', // Example role
          firebaseUser.photoURL ?? '');
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth exceptions
      switch (e.code) {
        case 'email-already-in-use':
          throw const ServerException('The email address is already in use.');
        // Add more cases as needed
        default:
          throw ServerException('Authentication error: ${e.message}');
      }
    } catch (e) {
      throw ServerException('An unknown error occurred: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final firebase_auth.User? firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        if (userDoc.exists) {
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        } else {
          return null;
        }
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException('Error resetting password: ${e.message}');
    } catch (e) {
      throw ServerException('An unknown error occurred: ${e.toString()}');
    }
  }
}
