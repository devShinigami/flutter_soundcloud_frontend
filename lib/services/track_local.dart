import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_cloud_clone/models/track.dart';

class TrackPreferences {
  static late SharedPreferences _prefs;
  static Future init() async => _prefs = await SharedPreferences.getInstance();
  static Future<void> saveCurrentTrack(Track track) async {
    _prefs.setString('currentTrack', track.toJson());
  }

  static Future<Track?> getCurrentTrack() async {
    String? track = _prefs.getString('currentTrack');
    if (track != null) {
      return Track.fromJson(track);
    }
    return null;
  }
}
