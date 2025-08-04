import 'dart:convert';

import 'data.dart';

class ChapterModel {
  String? message;
  Data? data;

  ChapterModel({this.message, this.data});

  factory ChapterModel.fromMap(Map<String, dynamic> data) => ChapterModel(
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
  /// Parses the string and returns the resulting Json object as [ChapterModel].
  factory ChapterModel.fromJson(String data) {
    return ChapterModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChapterModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
