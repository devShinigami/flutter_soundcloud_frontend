import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sound_cloud_clone/models/user_model.dart';

class UserServices {
  static const String baseUrl = 'http://192.168.100.14:3001/api/v1';

  Future<User> updateUser(Map<String, dynamic> changes,
      {required String id}) async {
    final url = Uri.parse('$baseUrl/update');
    final data = jsonEncode({
      'userFromClient': changes,
      'id': id,
    });

    try {
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );

      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode == 200) {
        return User.fromMap(resBodyMap['user']);
      } else if (res.statusCode == 400) {
        throw Exception(resBodyMap['message'] ?? 'Bad request');
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } catch (e) {
      if (e is FormatException) {
        throw Exception('Invalid response format');
      } else if (e is http.ClientException) {
        throw Exception('Network error: ${e.message}');
      } else {
        throw Exception('An unexpected error occurred: $e');
      }
    }
  }
}
