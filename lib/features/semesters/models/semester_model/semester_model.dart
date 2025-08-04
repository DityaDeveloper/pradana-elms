import 'dart:convert';

import 'data.dart';

class SemesterModel {
  String? message;
  Data? data;

  SemesterModel({this.message, this.data});

  factory SemesterModel.fromMap(Map<String, dynamic> data) => SemesterModel(
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
  /// Parses the string and returns the resulting Json object as [SemesterModel].
  factory SemesterModel.fromJson(String data) {
    return SemesterModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SemesterModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
