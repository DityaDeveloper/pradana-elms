import 'dart:convert';

import 'data.dart';

class TeacherModel {
  String? message;
  Data? data;

  TeacherModel({this.message, this.data});

  factory TeacherModel.fromMap(Map<String, dynamic> data) => TeacherModel(
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
  /// Parses the string and returns the resulting Json object as [TeacherModel].
  factory TeacherModel.fromJson(String data) {
    return TeacherModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeacherModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
