import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/User-Profile.dart';

class UserPreferance {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';
  static const myUser = User_Profile(
    imgPath: 'assets/images/Old Sterio.jpeg',
    name: 'Prabesh',
    email: 'prabesht09@gmail.com',
    contact: '9800000000',
    location: 'Dhulikhel, Kavre',
    about:
        'Here goes some description of the user. Like location, phone number whatever that helps the buyer connect with the user.',
    isDarkMode: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User_Profile user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User_Profile getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User_Profile.fromJson(jsonDecode(json));
  }
}
