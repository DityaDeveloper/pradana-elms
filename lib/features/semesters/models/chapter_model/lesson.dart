import 'dart:convert';

class Lesson {
  int? id;
  String? title;
  String? type;
  String? duration;
  String? media;
  int? mediaId;
  String? source;
  String? mediaLink;
  String? thumbnailLink;
  int? isFree;
  int? serialNumber;
  String? course;
  String? instructor;
  bool? isLocked;

  Lesson({
    this.id,
    this.title,
    this.type,
    this.duration,
    this.media,
    this.mediaId,
    this.source,
    this.mediaLink,
    this.thumbnailLink,
    this.isFree,
    this.serialNumber,
    this.course,
    this.instructor,
    this.isLocked,
  });

  factory Lesson.fromMap(Map<String, dynamic> data) => Lesson(
        id: data['id'] as int?,
        title: data['title'] as String?,
        type: data['type'] as String?,
        duration: data['duration'] as String?,
        media: data['media'] as String?,
        mediaId: data['media_id'] as int?,
        source: data['source'] as String?,
        mediaLink: data['media_link'] as String?,
        thumbnailLink: data['thumbnail_link'] as String?,
        isFree: data['is_free'] as int?,
        serialNumber: data['serial_number'] as int?,
        course: data['course'] as String?,
        instructor: data['instructor'] as String?,
        isLocked: data['is_locked'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'type': type,
        'duration': duration,
        'media': media,
        'media_id': mediaId,
        'source': source,
        'media_link': mediaLink,
        'thumbnail_link': thumbnailLink,
        'is_free': isFree,
        'serial_number': serialNumber,
        'course': course,
        'instructor': instructor,
        'is_locked': isLocked,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Lesson].
  factory Lesson.fromJson(String data) {
    return Lesson.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Lesson] to a JSON string.
  String toJson() => json.encode(toMap());
}
