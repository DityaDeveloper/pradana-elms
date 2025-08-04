import 'dart:convert';

class Page {
  int? id;
  String? title;
  String? slug;
  String? content;

  Page({this.id, this.title, this.slug, this.content});

  factory Page.fromMap(Map<String, dynamic> data) => Page(
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
  /// Parses the string and returns the resulting Json object as [Page].
  factory Page.fromJson(String data) {
    return Page.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Page] to a JSON string.
  String toJson() => json.encode(toMap());
}
