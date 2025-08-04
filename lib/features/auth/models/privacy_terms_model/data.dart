import 'dart:convert';

class Data {
  int? id;
  String? title;
  String? slug;
  String? content;

  Data({this.id, this.title, this.slug, this.content});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        id: data['id'] as int?,
        title: data['title'] as String?,
        slug: data['slug'] as String?,
        content: data['content'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'slug': slug,
        'content': content,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
