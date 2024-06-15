//import 'package:flutter/services.dart';

import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final String password;
  final String confirmpassword;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.token,
    required this.password,
    required this.confirmpassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': email,
      'password': password,
      'confirmpassword': confirmpassword,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      confirmpassword: map['confirmpassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
