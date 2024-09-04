import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:sound_cloud_clone/models/search.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  final String _baseUrl = 'http://192.168.100.14:3001/api/v1/search';
  Future<Either<String, SearchModel>> getSearchData(String query) async {
    try {
      final url = Uri.parse('$_baseUrl/$query');
      final res = await http.get(url);
      final resbodyMap = await jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200) {
        return Right(
          SearchModel.fromMap(
            resbodyMap['search'],
          ),
        );
      } else {
        return Left(resbodyMap['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
