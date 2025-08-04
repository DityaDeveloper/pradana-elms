import 'dart:convert';

import 'user.dart';

class Data {
  User? user;
  String? token;
  String? otpCode;

  Data({this.user, this.token, this.otpCode});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        token: data['token'] as String?,
        otpCode: data['otp_code'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'user': user?.toMap(),
        'token': token,
        'otp_code': otpCode,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
