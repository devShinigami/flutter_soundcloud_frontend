import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class TrackServices {
  final String _baseUrl = 'http://192.168.100.14:3001/api/v1/track';
  Future<void> uploadTrack(Map<String, dynamic> data,
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

      if (response.statusCode == 200) {
        print('Audio file uploaded successfully');
      } else {
        print(
            'Failed to upload audio file. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
