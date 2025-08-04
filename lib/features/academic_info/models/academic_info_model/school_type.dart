import 'dart:convert';

class SchoolType {
  int? id;
  String? title;
  int? countryId;

  SchoolType({this.id, this.title, this.countryId});

  factory SchoolType.fromMap(Map<String, dynamic> data) => SchoolType(
        id: data['id'] as int?,
        title: data['title'] as String?,
        countryId: data['country_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'country_id': countryId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SchoolType].
  factory SchoolType.fromJson(String data) {
    return SchoolType.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SchoolType] to a JSON string.
  String toJson() => json.encode(toMap());
}
