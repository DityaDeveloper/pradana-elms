import 'dart:convert';

class CategoryModel {
  int? id;
  String? name;
  int? isFeatured;

  CategoryModel({this.id, this.name, this.isFeatured});

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        isFeatured: data['is_featured'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'is_featured': isFeatured,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoryModel].
  factory CategoryModel.fromJson(String data) {
    return CategoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CategoryModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
