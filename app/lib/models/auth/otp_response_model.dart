import 'dart:convert';

import 'package:flutter/material.dart';

OtpResponseModel otpResponseJSON(String str) {
  return OtpResponseModel.fromJson(json.decode(str));
}

// OtpResponseModel optverifymdel() {
//   return OtpResponseModel.fromJson(json.decode(str));
// }

class OtpResponseModel {
  late final String message;
  late final String data;
  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data;
    return _data;
  }
}
