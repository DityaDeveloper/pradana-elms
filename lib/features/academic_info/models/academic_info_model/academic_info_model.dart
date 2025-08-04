import 'dart:convert';

import 'data.dart';

class AcademicInfoModel {
  String? message;
  Data? data;

  AcademicInfoModel({this.message, this.data});

  factory AcademicInfoModel.fromMap(Map<String, dynamic> data) {
    return AcademicInfoModel(
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
  /// Parses the string and returns the resulting Json object as [AcademicInfoModel].
  factory AcademicInfoModel.fromJson(String data) {
    return AcademicInfoModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AcademicInfoModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
