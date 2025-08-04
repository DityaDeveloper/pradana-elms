import 'dart:convert';

class Grade {
  int? id;
  String? title;
  int? countryId;

  Grade({this.id, this.title, this.countryId});

  factory Grade.fromMap(Map<String, dynamic> data) => Grade(
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
  /// Parses the string and returns the resulting Json object as [Grade].
  factory Grade.fromJson(String data) {
    return Grade.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Grade] to a JSON string.
  String toJson() => json.encode(toMap());
}
