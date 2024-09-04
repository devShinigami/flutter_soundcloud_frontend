// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sound_cloud_clone/models/search_user.dart';
import 'package:sound_cloud_clone/models/track.dart';

class SearchModel {
  final List<SearchUser> users;
  final List<Track> tracks;

  SearchModel({
    required this.users,
    required this.tracks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': users.map((x) => x.toMap()).toList(),
      'tracks': tracks.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      users: List<SearchUser>.from(
        (map['users'] as List<dynamic>).map<SearchUser>(
          (x) => SearchUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
      tracks: List<Track>.from(
        (map['tracks'] as List<dynamic>).map<Track>(
          (x) => Track.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) =>
      SearchModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
