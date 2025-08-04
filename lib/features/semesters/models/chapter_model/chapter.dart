import 'dart:convert';

import 'lesson.dart';
import 'resource.dart';

class Chapter {
  int? id;
  String? title;
  String? semester;
  List<Lesson>? lessons;
  List<Resource>? resources;

  Chapter({
    this.id,
    this.title,
    this.semester,
    this.lessons,
    this.resources,
  });

  factory Chapter.fromMap(Map<String, dynamic> data) => Chapter(
        id: data['id'] as int?,
        title: data['title'] as String?,
        semester: data['semester'] as String?,
        lessons: (data['lessons'] as List<dynamic>?)
            ?.map((e) => Lesson.fromMap(e as Map<String, dynamic>))
            .toList(),
        resources: (data['resources'] as List<dynamic>?)
            ?.map((e) => Resource.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'semester': semester,
        'lessons': lessons?.map((e) => e.toMap()).toList(),
        'resources': resources?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Chapter].
  factory Chapter.fromJson(String data) {
    return Chapter.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Chapter] to a JSON string.
  String toJson() => json.encode(toMap());
}
