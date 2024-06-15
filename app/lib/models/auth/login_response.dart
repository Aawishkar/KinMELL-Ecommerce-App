import 'dart:convert';

LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(
      json.decode(str),
    );

class LoginResponseModel {
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['message'] = message;
    _data['data'] = data.toJson();

    return _data;
  }
}

class Data {
  late final String name;
  late final String email;
  late final String userId;
  late final String token;

  Data(
      {required this.name,
      required this.email,
      required this.userId,
      required this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    userId = json["userId"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['name'] = name;
    _data['email'] = email;
    _data['userId'] = userId;
    _data['token'] = name;

    return _data;
  }
}



// LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(
//       json.decode(str),
//     );

// class LoginResponseModel {
//   LoginResponseModel({
//     required this.message,
//     required this.token,
//     required this.user,
//   });
//   late final String message;
//   late final String token;
//   late final List<User> user;

//   LoginResponseModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     token = json['token'];
//     user = List.from(json['user']).map((e) => User.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['message'] = message;
//     _data['token'] = token;
//     _data['user'] = user.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class User {
//   User({
//     required this.name,
//     required this.email,
//     required this.profilePicture,
//     required this.coverPicture,
//     required this.followers,
//     required this.followings,
//     required this.userId,
//   });
//   late final String name;
//   late final String email;
//   late final String profilePicture;
//   late final String coverPicture;
//   late final List<dynamic> followers;
//   late final List<dynamic> followings;
//   late final String userId;

//   User.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     email = json['email'];
//     profilePicture = json['profilePicture'];
//     coverPicture = json['coverPicture'];
//     followers = List.castFrom<dynamic, dynamic>(json['followers']);
//     followings = List.castFrom<dynamic, dynamic>(json['followings']);
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['email'] = email;
//     _data['profilePicture'] = profilePicture;
//     _data['coverPicture'] = coverPicture;
//     _data['followers'] = followers;
//     _data['followings'] = followings;
//     _data['userId'] = userId;
//     return _data;
//   }
// }
