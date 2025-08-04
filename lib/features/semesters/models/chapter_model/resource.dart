import 'dart:convert';

class Resource {
  String? title;
  String? media;
  String? type;
  bool? isLocked;

  Resource({this.title, this.media, this.type, this.isLocked});

  factory Resource.fromMap(Map<String, dynamic> data) => Resource(
        title: data['title'] as String?,
        media: data['media'] as String?,
        type: data['type'] as String?,
        isLocked: data['is_locked'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'media': media,
        'type': type,
        'is_locked': isLocked,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Resource].
  factory Resource.fromJson(String data) {
    return Resource.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Resource] to a JSON string.
  String toJson() => json.encode(toMap());
}
