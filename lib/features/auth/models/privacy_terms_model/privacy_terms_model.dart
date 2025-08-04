import 'dart:convert';

import 'data.dart';

class PrivacyTermsModel {
  String? message;
  Data? data;

  PrivacyTermsModel({this.message, this.data});

  factory PrivacyTermsModel.fromMap(Map<String, dynamic> data) {
    return PrivacyTermsModel(
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
  /// Parses the string and returns the resulting Json object as [PrivacyTermsModel].
  factory PrivacyTermsModel.fromJson(String data) {
    return PrivacyTermsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PrivacyTermsModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
