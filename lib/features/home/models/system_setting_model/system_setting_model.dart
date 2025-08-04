import 'dart:convert';

import 'data.dart';

class SystemSettingModel {
  String? message;
  Data? data;

  SystemSettingModel({this.message, this.data});

  factory SystemSettingModel.fromMap(Map<String, dynamic> data) {
    return SystemSettingModel(
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SystemSettingModel].
  factory SystemSettingModel.fromJson(String data) {
    return SystemSettingModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SystemSettingModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
