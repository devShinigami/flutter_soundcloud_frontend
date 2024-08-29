import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:sound_cloud_clone/models/user_model.dart';

final userServicesProvider = Provider<UserServices>((ref) {
  return UserServices();
});

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

  Future<User?> getUser(String id) async {
    final url = Uri.parse('$baseUrl/profile/$id');
    try {
      final res = await http.get(url);
      final resBodyMap = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        return User.fromMap(resBodyMap['user']);
      } else if (res.statusCode == 400) {
        return throw resBodyMap['message'] ?? 'Bad request';
      } else {
        throw Exception('Unexpected status code: ${res.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
