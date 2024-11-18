import 'dart:convert';
import 'package:book_store/api_config.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:book_store/features/book/data/datasourses/local/local_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_store/features/book/data/model/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for loading assets

abstract class AuthRemoteDataSource {
  final firebase_auth.User? firebaseUser;

  final LocalData localData;

  AuthRemoteDataSource(this.firebaseUser, this.localData);

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithNamePassword({
    required String name,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> updateUser(
    String id,
    String email,
    String phone,
    String fullName,
    String address,
  );

  Future<UserModel?> getCurrentUserData();

  Future<UserModel?> getUser();

  Future<String?> getToken();
  Future<void> resetPassword({required String email});
  Future<void> signOut();
  Future<String?> verifyCode(String email);
}

class AuthRemoteDataSourceImple implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  final LocalData localData;

  AuthRemoteDataSourceImple(this.firebaseAuth, this.localData);

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

      final userModel = await getCurrentUserData();
      if (userModel == null) {
        throw const ServerException('Failed to retrieve user data.');
      }

      return userModel;
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
    final url = Uri.parse(ApiConfig.registerEndpoint);

    final request = http.MultipartRequest('POST', url)
      ..fields['UserJson'] = jsonEncode({
        "username": name,
        "password": password,
        "email": email,
        "phone": "",
        "fullname": "",
        "address": ""
      });

    // Load the image from assets as a byte array
    final imageData = await _loadImageFromAssets('assets/account.png');

    // Add the image to the request as multipart
    request.files.add(
      http.MultipartFile.fromBytes(
        'imageFile',
        imageData,
        filename: 'account.png',
        contentType: MediaType('image', 'png'),
      ),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        // print('Register successfully: $responseData');

        var jsonData = json.decode(responseData);
        final user = UserModel(
          jsonData['user']['userId'].toString(),
          jsonData['user']['profileImage'].toString(),
          jsonData['user']['username'].toString(),
          jsonData['user']['password'].toString(),
          jsonData['user']['email'].toString(),
          jsonData['user']['phone'].toString(),
          jsonData['user']['address'].toString(),
          jsonData['user']['roleId'].toString(),
          jsonData['user']['fullname'].toString(),
        );
        return user;
      } else {
        final responseBody = await response.stream.bytesToString();
        throw Exception(
            'Failed to register: ${response.statusCode} - $responseBody');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Future<String> loginWithNamePassword(
      {required String name, required String password}) async {
    final url = Uri.parse(ApiConfig.loginEndpoint);
    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json-patch+json',
    };

    final body = jsonEncode({
      'username': name,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print('haha');
        final data = jsonDecode(response.body);
        final token = data['token'] as String?;

        // Xử lý thành công
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          return token;
        } else {
          throw Exception("Login failed");
        }
      } else {
        throw Exception("Login failed: Invalid credentials or server error");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  // Helper function to load image from assets
  Future<List<int>> _loadImageFromAssets(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Lấy token từ SharedPreferences

    return token;
  }

  @override
  Future<UserModel?> getUser() async {
    const url = ApiConfig.getUser;
    final token = await getToken();

    try {
      final res = await http.get(Uri.parse(url), headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      });

      if (res.statusCode == 200) {
        var jsonData = json.decode(res.body);
        final user = UserModel(
          jsonData['userId'].toString(),
          jsonData['profileImage'].toString(),
          jsonData['username'].toString(),
          jsonData['password'].toString(),
          jsonData['email'].toString(),
          jsonData['phone'].toString(),
          jsonData['address'].toString(),
          jsonData['roleId'].toString(),
          jsonData['fullname'].toString(),
        );

        return user;
      } else {
        return null;
      }
    } catch (e) {
      // Ném ra lỗi nếu có bất kỳ lỗi nào trong quá trình yêu cầu HTTP hoặc phân tích JSON
      throw Exception('Error: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;
      if (firebaseUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>;
          return UserModel.fromJson(data);
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
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      // await firebaseAuth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateUser(String id, String email, String phone,
      String fullName, String address) async {
    final url = Uri.parse('${ApiConfig.updateUser}$id');
    final token = await getToken();

    final headers = {
      'accept': '*/*',
      'Content-Type': 'application/json-patch+json',
      'Authorization': 'Bearer $token'
    };

    final body = jsonEncode({
      'email': email,
      'phone': phone,
      'fullname': fullName,
      'address': address,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      // print(response.statusCode);
      if (response.statusCode == 200) {
      } else {
        throw Exception("Login failed: Invalid credentials or server error");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<String?> verifyCode(String email) async {
    final url = Uri.parse('${ApiConfig.verifyCode}$email');
    final headers = {
      'accept': '*/*',
    };

    try {
      final response = await http.post(url, headers: headers);

      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print('haha');
        final data = jsonDecode(response.body);
        final token = data['token'] as String?;

        print(token);

        // Xử lý thành công
        if (token != null) {
          return token;
        } else {
          throw Exception("Fail to send verify code");
        }
      } else {
        throw Exception("Fail to send verify code");
      }
    } catch (e) {
      throw Exception("Fail to send verify code: $e");
    }
  }
}
