import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class SuggestionService {
  final String _baseUrl = 'http://192.168.100.14:3001/api/v1/suggestions';

  Future<Either<String, List<String>>> getSuggestions(String query) async {
    try {
      final url = Uri.parse('$_baseUrl/$query');
      final response = await http.get(url);
      final resbodyMap =
          await jsonDecode(response.body) as Map<String, dynamic>;
      log(resbodyMap.toString());
      if (response.statusCode == 200) {
        List<String> suggestions = [];
        suggestions.addAll((resbodyMap['suggestions'] as List<dynamic>)
            .map((e) => e.toString()));
        return Right(suggestions);
      } else {
        return Left(resbodyMap['message']);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
