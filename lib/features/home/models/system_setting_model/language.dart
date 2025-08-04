import 'dart:convert';

class Language {
  int? id;
  String? name;
  String? locale;
  String? flag;
  String? textDirection;

  Language({
    this.id,
    this.name,
    this.locale,
    this.flag,
    this.textDirection,
  });

  factory Language.fromMap(Map<String, dynamic> data) => Language(
        id: data['id'] as int?,
        name: data['name'] as String?,
        locale: data['locale'] as String?,
        flag: data['flag'] as String?,
        textDirection: data['text_direction'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'locale': locale,
        'flag': flag,
        'text_direction': textDirection,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Language].
  factory Language.fromJson(String data) {
    return Language.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Language] to a JSON string.
  String toJson() => json.encode(toMap());
}
