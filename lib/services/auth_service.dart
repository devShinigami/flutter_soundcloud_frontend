import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sound_cloud_clone/models/user_model.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.100.14:3001/api/v1';

  Future<User?> logIn({required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final data = jsonEncode({
      'email': email,
      'password': password,
    });

    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data);
    final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      final user = User.fromMap(resBodyMap['user']);
      return user;
    } else if (res.statusCode == 400) {
      print(resBodyMap['message']);
    }
    return null;
  }
}
