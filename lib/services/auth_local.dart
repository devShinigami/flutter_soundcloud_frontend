import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:sound_cloud_clone/models/user_model.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future saveUser(Map<String, dynamic> userData) async {
    log(userData.toString());
    await _prefs.setString('userData', jsonEncode(userData));
  }

  static Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  static Future saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  static Future<User?> getUserData() async {
    final userDataString = _prefs.getString('userData');
    print(userDataString);
    if (userDataString != null) {
      final user = User.fromJson(userDataString);
      return user;
    }
    return null;
  }

  static Future clearUser() async {
    await _prefs.remove('token');
    await _prefs.remove('userData');
  }
}
