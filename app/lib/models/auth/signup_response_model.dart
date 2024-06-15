import 'dart:convert';

SignupResponseModel signupResponseJson(String str) =>
    SignupResponseModel.fromJson(
      json.decode(str),
    );

class SignupResponseModel {
  SignupResponseModel({
    required this.message,
    required this.user,
  });
  late final String message;
  late final User? user;

  SignupResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['user'] = user!.toJson();
    return _data;
  }
}

class User {
  User({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.coverPicture,
    required this.followers,
    required this.followings,
    required this.userId,
  });
  late final String name;
  late final String email;
  late final String profilePicture;
  late final String coverPicture;
  late final List<dynamic> followers;
  late final List<dynamic> followings;
  late final String userId;

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    coverPicture = json['coverPicture'];
    followers = List.castFrom<dynamic, dynamic>(json['followers']);
    followings = List.castFrom<dynamic, dynamic>(json['followings']);
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['profilePicture'] = profilePicture;
    _data['coverPicture'] = coverPicture;
    _data['followers'] = followers;
    _data['followings'] = followings;
    _data['userId'] = userId;
    return _data;
  }
}
