import 'dart:convert';

import 'data.dart';

class HomeModel {
  String? message;
  Data? data;

  HomeModel({this.message, this.data});

  factory HomeModel.fromMap(Map<String, dynamic> data) => HomeModel(
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
  /// Parses the string and returns the resulting Json object as [HomeModel].
  factory HomeModel.fromJson(String data) {
    return HomeModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HomeModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
