import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_local_services.g.dart';

@Riverpod(keepAlive: true)
UserLocalServices userLocalServices(UserLocalServicesRef ref) {
  return UserLocalServices();
}

class UserLocalServices {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) {
    if (token != null) {
      _sharedPreferences.setString('token', token);
    }
  }

  String? getToken() {
    return _sharedPreferences.getString('token');
  }
}
