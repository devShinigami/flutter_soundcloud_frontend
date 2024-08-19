import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String bio;
  final ProfilePic profilePic;
  final BannerPic bannerPic;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> tracks;
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
    ProfilePic? profilePic,
    BannerPic? bannerPic,
    List<dynamic>? followers,
    List<dynamic>? following,
    List<dynamic>? tracks,
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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'profilePic': profilePic.toJson(),
      'bannerPic': bannerPic.toJson(),
      'followers': followers,
      'following': following,
      'tracks': tracks,
      'likes': likes,
      'playlists': playlists,
      'createdAt': createdAt.toIso8601String(),
      'token': token,
      'city': city,
      'country': country,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      bio: map['bio'] ?? "",
      profilePic: ProfilePic.fromMap(map['profilePic'] ?? {}),
      bannerPic: BannerPic.fromMap(map['bannerPic'] ?? {}),
      followers: List<dynamic>.from(map['followers'] ?? []),
      following: List<dynamic>.from(map['following'] ?? []),
      tracks: List<dynamic>.from(map['tracks'] ?? []),
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

class ProfilePic {
  final String publicId;
  final String url;

  ProfilePic({required this.publicId, required this.url});

  ProfilePic copyWith({
    String? publicId,
    String? url,
  }) {
    return ProfilePic(
      publicId: publicId ?? this.publicId,
      url: url ?? this.url,
    );
  }

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      publicId: json['public_id'],
      url: json['url'],
    );
  }
  factory ProfilePic.fromMap(Map<String, dynamic> map) {
    return ProfilePic(
      publicId: map['public_id'] ?? "",
      url: map['url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfilePic &&
        other.publicId == publicId &&
        other.url == url;
  }

  @override
  int get hashCode {
    return publicId.hashCode ^ url.hashCode;
  }

  @override
  String toString() {
    return 'ProfilePic(publicId: $publicId, url: $url)';
  }
}

class BannerPic {
  final String publicId;
  final String url;

  BannerPic({required this.publicId, required this.url});

  BannerPic copyWith({
    String? publicId,
    String? url,
  }) {
    return BannerPic(
      publicId: publicId ?? this.publicId,
      url: url ?? this.url,
    );
  }

  factory BannerPic.fromMap(Map<String, dynamic> map) {
    return BannerPic(
      publicId: map['public_id'] ?? "",
      url: map['url'] ?? "",
    );
  }

  factory BannerPic.fromJson(Map<String, dynamic> json) {
    return BannerPic(
      publicId: json['public_id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'public_id': publicId,
      'url': url,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerPic && other.publicId == publicId && other.url == url;
  }

  @override
  int get hashCode {
    return publicId.hashCode ^ url.hashCode;
  }

  @override
  String toString() {
    return 'BannerPic(publicId: $publicId, url: $url)';
  }
}
