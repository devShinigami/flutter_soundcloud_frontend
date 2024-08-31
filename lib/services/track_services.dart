import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:sound_cloud_clone/models/track.dart';

class TrackServices {
  final String _baseUrl = 'http://192.168.100.14:3001/api/v1/track';

  Future<Either<String, Track>> uploadTrack(Map<String, dynamic> data,
      {required String id, required File audioFile}) async {
    try {
      final trackMap = jsonEncode({
        'track': data,
      });
      final url = Uri.parse('$_baseUrl/upload');
      var request = http.MultipartRequest('POST', url);
      var file = await http.MultipartFile.fromPath('audio', audioFile.path);
      request.files.add(file);
      request.fields['track'] = trackMap;
      request.fields['userId'] = id;
      request.headers['content-type'] = 'application/json';
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final resbodyMap =
          await jsonDecode(response.body) as Map<String, dynamic>;
      log(resbodyMap.toString());

      if (response.statusCode == 200) {
        return Right(
          Track.fromMap(
            resbodyMap['track'],
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
