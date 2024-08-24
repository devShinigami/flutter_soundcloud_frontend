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

    try {
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
        throw Exception(resBodyMap['message']);
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    final url = Uri.parse('$baseUrl/auth/create');

    final data = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 201) {
        return resBodyMap;
      } else if (res.statusCode == 400) {
        throw Exception(resBodyMap['message']);
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
