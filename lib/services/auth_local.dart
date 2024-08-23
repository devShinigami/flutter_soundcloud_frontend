import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:sound_cloud_clone/models/user_model.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future saveUser(Map<String, dynamic> userData) async {
    await _prefs.setString('userData', json.encode(userData));
  }

  static Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  static Future saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  static Future<User?> getUserData() async {
    final userDataString = _prefs.getString('userData');
    if (userDataString != null) {
      final userMap = json.decode(userDataString) as Map<String, dynamic>;
      return User.fromMap(userMap);
    }
    return null;
  }

  static Future clearUser() async {
    await _prefs.remove('token');
    await _prefs.remove('userData');
  }
}
