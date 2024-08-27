import 'dart:convert';

class Track {
  final String title;
  final String user;
  final int timesOfPlayed;
  final TrackData trackData;
  final int duration;
  final String genre;
  final bool isPrivate;
  final DateTime createdAt;
  final String id;

  Track({
    required this.title,
    required this.user,
    required this.timesOfPlayed,
    required this.trackData,
    required this.duration,
    required this.genre,
    required this.isPrivate,
    required this.createdAt,
    required this.id,
  });

  Track copyWith({
    String? title,
    String? user,
    int? timesOfPlayed,
    TrackData? trackData,
    int? duration,
    String? genre,
    bool? isPrivate,
    DateTime? createdAt,
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
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'user': user,
      'timesOfPlayed': timesOfPlayed,
      'trackData': trackData.toMap(),
      'duration': duration,
      'genre': genre,
      'isPrivate': isPrivate,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'id': id,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      title: map['title'] ?? '',
      user: map['user'] ?? '',
      timesOfPlayed: map['timesOfPlayed'] ?? 0,
      trackData: TrackData.fromMap(map['trackData'] ?? {}),
      duration: map['duration'] ?? 0,
      genre: map['genre'] ?? '',
      isPrivate: map['isPrivate'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
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
