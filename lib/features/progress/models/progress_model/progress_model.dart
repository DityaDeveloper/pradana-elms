import 'dart:convert';

import 'data.dart';

class ProgressModel {
  String? message;
  Data? data;

  ProgressModel({this.message, this.data});

  factory ProgressModel.fromMap(Map<String, dynamic> data) => ProgressModel(
        message: data['message'] as String?,
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProgressModel].
  factory ProgressModel.fromJson(String data) {
    return ProgressModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProgressModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
