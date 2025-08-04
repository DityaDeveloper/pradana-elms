import 'dart:convert';

class CityModel {
  int? id;
  String? name;

  CityModel({this.id, this.name});

  factory CityModel.fromMap(Map<String, dynamic> data) => CityModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CityModel].
  factory CityModel.fromJson(String data) {
    return CityModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CityModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
