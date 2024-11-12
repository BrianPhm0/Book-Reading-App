import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('authToken');
  }

  @override
  Future<void> removeToken() async {
    await sharedPreferences.remove('authToken');
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('authToken', token);
  }
}
