// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Model needs to have the same value as the model in node.js
class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String address;
  final String type;
  final String token;

  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.password,
      required this.address,
      required this.type,
      required this.token});

  // User copyWith({
  //   String? id,
  //   String? email,
  //   String? name,
  //   String? password,
  //   String? address,
  //   String? type,
  //   String? token,
  // }) {
  //   return User(
  //     id ?? this.id,
  //     email ?? this.email,
  //     name ?? this.name,
  //     password ?? this.password,
  //     address ?? this.address,
  //     type ?? this.type,
  //     token ?? this.token,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
    };
  }

// From map it will give you a user
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

// From json will convert it map then from map it will give you the user
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, password: $password, address: $address, type: $type, token: $token)';
  }
}
