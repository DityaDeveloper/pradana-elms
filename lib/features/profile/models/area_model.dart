import 'dart:convert';

class AreaModel {
  int? id;
  String? name;

  AreaModel({this.id, this.name});

  factory AreaModel.fromMap(Map<String, dynamic> data) => AreaModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AreaModel].
  factory AreaModel.fromJson(String data) {
    return AreaModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AreaModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
