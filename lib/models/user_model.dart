import 'dart:convert';

class User {
  final String name;
  final String email;
  final String id;
  User({
    required this.name,
    required this.email,
    required this.id,
  });
  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      '_id': id,
    };
  }

  // Create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  // Convert User object to JSON string
  String toJson() => json.encode(toMap());

  // Create a User object from a JSON string
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  // Create a copy of User with optional parameter overrides
  User copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.email == email &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ id.hashCode;
}
