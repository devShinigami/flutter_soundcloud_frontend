// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String id;
  final String token;
  final String city;
  User({
    required this.name,
    required this.city,
    required this.email,
    required this.id,
    required this.token,
  });
  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
      'token': token,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['_id'] ?? '',
      token: map['token'] ?? '',
      city: map['city'] ?? '',
    );
  }

  // Convert User object to JSON string
  String toJson() => json.encode(toMap());

  // Create a User object from a JSON string
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  // Create a copy of User with optional parameter overrides
  User copyWith({
    String? name,
    String? email,
    String? id,
    String? token,
    String? city,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      city: city ?? this.city,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, id: $id, token: $token, city: $city)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.id == id &&
        other.token == token &&
        other.city == city;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        id.hashCode ^
        token.hashCode ^
        city.hashCode;
  }
}
