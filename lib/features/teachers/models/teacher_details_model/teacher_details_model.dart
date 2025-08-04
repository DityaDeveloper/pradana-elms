import 'dart:convert';

import 'data.dart';

class TeacherDetailsModel {
  String? message;
  Data? data;

  TeacherDetailsModel({this.message, this.data});

  factory TeacherDetailsModel.fromMap(Map<String, dynamic> data) {
    return TeacherDetailsModel(
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
  /// Parses the string and returns the resulting Json object as [TeacherDetailsModel].
  factory TeacherDetailsModel.fromJson(String data) {
    return TeacherDetailsModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeacherDetailsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
