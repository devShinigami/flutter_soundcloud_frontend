import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:sound_cloud_clone/models/user_model.dart';
import 'package:sound_cloud_clone/utils/failure.dart';

class UserServices {
  static const String baseUrl = 'http://192.168.100.14:3001/api/v1';

  Future<Either<Failure, User>> signUp(
      String name, String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/create');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(Failure(resBodyMap['message']));
      }
      return Right(User.fromMap(resBodyMap));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      print(resBodyMap);
      if (response.statusCode != 200) {
        return Left(Failure(resBodyMap['message']));
      }
      return Right(User.fromMap(resBodyMap));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
