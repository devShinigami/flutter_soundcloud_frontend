// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sound_cloud_clone/models/image.dart';

class SearchUser {
  final String id;
  final String name;
  final String country;
  final List<dynamic> followers;
  final ImageDataClass profilePic;
  SearchUser({
    required this.id,
    required this.profilePic,
    required this.name,
    required this.country,
    required this.followers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'country': '',
      'followers': followers,
    };
  }

  factory SearchUser.fromMap(Map<String, dynamic> map) {
    return SearchUser(
      profilePic: ImageDataClass.fromMap(map['profilePic']),
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      country: map.containsKey('country') ? map['country'] ?? "" : "",
      followers: map['followers'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchUser.fromJson(String source) =>
      SearchUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
