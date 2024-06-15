import 'package:flutter/cupertino.dart';

class User_Profile {
  final String imgPath;
  final String name;
  final String email;
  final String contact;
  final String location;
  final String about;
  final bool isDarkMode;

  const User_Profile({
    required this.imgPath,
    required this.name,
    required this.email,
    required this.contact,
    required this.location,
    required this.about,
    required this.isDarkMode,
  });
  User_Profile copy({
    String? imgPath,
    String? name,
    String? email,
    String? contact,
    String? location,
    String? about,
    bool? isDarkMode,
  }) =>
      User_Profile(
        imgPath: imgPath ?? this.imgPath,
        name: name ?? this.name,
        email: email ?? this.email,
        contact: contact ?? this.contact,
        location: location ?? this.location,
        about: about ?? this.about,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  static User_Profile fromJson(Map<String, dynamic> json) => User_Profile(
        imgPath: json['imgPath'],
        name: json['name'],
        email: json['email'],
        contact: json['contact'],
        location: json['location'],
        about: json['about'],
        isDarkMode: json['isDarkMode'],
      );

  Map<String, dynamic> toJson() => {
        'imgPath': imgPath,
        'name': name,
        'email': email,
        'contact': contact,
        'location': location,
        'about': about,
        'isDarkMode': isDarkMode,
      };
}
