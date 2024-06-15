class OtpResponseModel {
  OtpResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final String? data;

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
