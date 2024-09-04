// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sound_cloud_clone/models/image.dart';

class Track {
  final String title;
  final TrackUser user;
  final int timesOfPlayed;
  final ImageDataClass trackImage;
  final TrackData trackData;
  final TrackDuration duration;
  final String genre;
  final bool isPrivate;
  final DateTime createdAt;
  final String id;

  Track({
    required this.title,
    required this.user,
    required this.timesOfPlayed,
    required this.trackData,
    required this.trackImage,
    required this.duration,
    required this.genre,
    required this.isPrivate,
    required this.createdAt,
    required this.id,
  });

  Track copyWith({
    String? title,
    TrackUser? user,
    int? timesOfPlayed,
    TrackData? trackData,
    TrackDuration? duration,
    String? genre,
    bool? isPrivate,
    DateTime? createdAt,
    ImageDataClass? trackImage,
    String? id,
  }) =>
      Track(
        title: title ?? this.title,
        user: user ?? this.user,
        timesOfPlayed: timesOfPlayed ?? this.timesOfPlayed,
        trackData: trackData ?? this.trackData,
        duration: duration ?? this.duration,
        genre: genre ?? this.genre,
        isPrivate: isPrivate ?? this.isPrivate,
        trackImage: trackImage ?? this.trackImage,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'user': user.toMap(),
      'timesOfPlayed': timesOfPlayed,
      'trackData': trackData.toMap(),
      'duration': duration.toMap(),
      'genre': genre,
      'isPrivate': isPrivate,
      'createdAt': createdAt.toIso8601String(),
      'id': id,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      title: map['title'] ?? '',
      trackImage: ImageDataClass.fromMap(map['trackImage'] ?? {}),
      user: TrackUser.fromMap(map['user'] ?? {}),
      timesOfPlayed: map['timesOfPlayed'] ?? 0,
      trackData: TrackData.fromMap(map['trackData'] ?? {}),
      duration: TrackDuration.fromMap(map['duration'] ?? {}),
      genre: map['genre'] ?? '',
      isPrivate: map['isPrivate'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt']) ?? DateTime.now(),
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) =>
      Track.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TrackData {
  final String publicId;
  final String url;

  TrackData({
    required this.publicId,
    required this.url,
  });

  TrackData copyWith({
    String? publicId,
    String? url,
  }) =>
      TrackData(
        publicId: publicId ?? this.publicId,
        url: url ?? this.url,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publicId': publicId,
      'url': url,
    };
  }

  factory TrackData.fromMap(Map<String, dynamic> map) {
    return TrackData(
      publicId: map['publicId'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackData.fromJson(String source) =>
      TrackData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TrackDuration {
  final int inSeconds;
  final int inMinutes;

  TrackDuration({
    required this.inSeconds,
    required this.inMinutes,
  });

  TrackDuration copyWith({
    int? inSeconds,
    int? inMinutes,
  }) {
    return TrackDuration(
      inSeconds: inSeconds ?? this.inSeconds,
      inMinutes: inMinutes ?? this.inMinutes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inSeconds': inSeconds,
      'inMinutes': inMinutes,
    };
  }

  factory TrackDuration.fromMap(Map<String, dynamic> map) {
    return TrackDuration(
      inSeconds: map['inSeconds'] ?? 0,
      inMinutes: map['inMinutes'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackDuration.fromJson(String source) =>
      TrackDuration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant TrackDuration other) {
    if (identical(this, other)) return true;

    return other.inSeconds == inSeconds && other.inMinutes == inMinutes;
  }

  @override
  int get hashCode => inSeconds.hashCode ^ inMinutes.hashCode;
}

class TrackUser {
  final String id;
  final String name;
  final String city;
  final String country;
  final ImageDataClass profilePic;

  const TrackUser({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'city': city,
      'country': country,
      'profilePic': profilePic.toJson(),
    };
  }

  factory TrackUser.fromMap(Map<String, dynamic> map) {
    return TrackUser(
      id: map.containsKey('id') ? map['id'] ?? '' : '',
      name: map.containsKey('name') ? map['name'] ?? '' : '',
      city: map.containsKey('city') ? map['city'] ?? '' : '',
      country: map.containsKey('country') ? map['country'] ?? '' : '',
      profilePic: map.containsKey('profilePic')
          ? ImageDataClass.fromMap(map['profilePic'] ?? {})
          : ImageDataClass.fromMap({}),
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackUser.fromJson(String source) =>
      TrackUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrackUser(id: $id, name: $name, city: $city, country: $country, profilePic: $profilePic)';
  }

  @override
  bool operator ==(covariant TrackUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.city == city &&
        other.country == country &&
        other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        city.hashCode ^
        country.hashCode ^
        profilePic.hashCode;
  }

  TrackUser copyWith({
    String? id,
    String? name,
    String? city,
    String? country,
    ImageDataClass? profilePic,
  }) {
    return TrackUser(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      country: country ?? this.country,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}
