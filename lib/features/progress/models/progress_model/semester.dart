import 'dart:convert';

class Semester {
  int? id;
  String? title;
  bool? isLocked;

  Semester({this.id, this.title, this.isLocked});

  factory Semester.fromMap(Map<String, dynamic> data) => Semester(
        id: data['id'] as int?,
        title: data['title'] as String?,
        isLocked: data['is_locked'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'is_locked': isLocked,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Semester].
  factory Semester.fromJson(String data) {
    return Semester.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Semester] to a JSON string.
  String toJson() => json.encode(toMap());
}
