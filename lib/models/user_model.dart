import 'dart:convert';
import 'package:sound_cloud_clone/models/track.dart';

import '../models/image.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String bio;
  final ImageDataClass profilePic;
  final ImageDataClass bannerPic;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<Track> tracks;
  final List<dynamic> likes;
  final List<dynamic> playlists;
  final DateTime createdAt;
  final String token;
  final String city;
  final String country;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.profilePic,
    required this.bannerPic,
    required this.followers,
    required this.following,
    required this.tracks,
    required this.likes,
    required this.playlists,
    required this.createdAt,
    required this.token,
    required this.city,
    required this.country,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? bio,
    ImageDataClass? profilePic,
    ImageDataClass? bannerPic,
    List<dynamic>? followers,
    List<dynamic>? following,
    List<Track>? tracks,
    List<dynamic>? likes,
    List<dynamic>? playlists,
    DateTime? createdAt,
    String? token,
    String? city,
    String? country,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profilePic: profilePic ?? this.profilePic,
      bannerPic: bannerPic ?? this.bannerPic,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      tracks: tracks ?? this.tracks,
      likes: likes ?? this.likes,
      playlists: playlists ?? this.playlists,
      createdAt: createdAt ?? this.createdAt,
      token: token ?? this.token,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  factory User.fromJson(String json) {
    return User.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'profilePic': profilePic.toJson(),
      'bannerPic': bannerPic.toJson(),
      'followers': followers,
      'following': following,
      'tracks': tracks.map((x) => x.toMap()).toList(),
      'likes': likes,
      'playlists': playlists,
      'createdAt': createdAt.toIso8601String(),
      'token': token,
      'city': city,
      'country': country,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.empty() {
    return User(
      id: "",
      name: "",
      email: "",
      bio: "",
      profilePic: ImageDataClass.fromMap({}),
      bannerPic: ImageDataClass.fromMap({}),
      followers: [],
      following: [],
      tracks: [],
      likes: [],
      playlists: [],
      createdAt: DateTime.now(),
      token: "",
      city: "",
      country: "",
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      bio: map['bio'] ?? "",
      profilePic: ImageDataClass.fromMap(map['profilePic'] ?? {}),
      bannerPic: ImageDataClass.fromMap(map['bannerPic'] ?? {}),
      followers: List<dynamic>.from(map['followers'] ?? []),
      following: List<dynamic>.from(map['following'] ?? []),
      tracks: (map['tracks'] as List<dynamic>? ?? [])
          .map((track) => Track.fromMap(track as Map<String, dynamic>))
          .toList(),
      likes: List<dynamic>.from(map['likes'] ?? []),
      playlists: List<dynamic>.from(map['playlists'] ?? []),
      createdAt: DateTime.tryParse(map['createdAt']) ?? DateTime.now(),
      token: map['token'] ?? "",
      city: map['city'] ?? "",
      country: map['country'] ?? "",
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.bio == bio &&
        other.profilePic == profilePic &&
        other.bannerPic == bannerPic &&
        other.followers == followers &&
        other.following == following &&
        other.tracks == tracks &&
        other.likes == likes &&
        other.playlists == playlists &&
        other.createdAt == createdAt &&
        other.token == token &&
        other.city == city &&
        other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        profilePic.hashCode ^
        bannerPic.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        tracks.hashCode ^
        likes.hashCode ^
        playlists.hashCode ^
        createdAt.hashCode ^
        token.hashCode ^
        city.hashCode ^
        country.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, bio: $bio, profilePic: $profilePic, bannerPic: $bannerPic, followers: $followers, following: $following, tracks: $tracks, likes: $likes, playlists: $playlists, createdAt: $createdAt, token: $token, city: $city, country: $country)';
  }
}
