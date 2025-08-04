import 'dart:convert';

class Course {
  int? id;
  String? title;
  String? thumbnail;
  int? courseProgressPercentage;
  int? examProgressPercentage;
  int? instructorId;

  Course({
    this.id,
    this.title,
    this.thumbnail,
    this.courseProgressPercentage,
    this.examProgressPercentage,
    this.instructorId,
  });

  factory Course.fromMap(Map<String, dynamic> data) => Course(
        id: data['id'] as int?,
        title: data['title'] as String?,
        thumbnail: data['thumbnail'] as String?,
        courseProgressPercentage: data['course_progress_percentage'] as int?,
        examProgressPercentage: data['exam_progress_percentage'] as int?,
        instructorId: data['instructor_id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'thumbnail': thumbnail,
        'course_progress_percentage': courseProgressPercentage,
        'exam_progress_percentage': examProgressPercentage,
        'instructor_id': instructorId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Course].
  factory Course.fromJson(String data) {
    return Course.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Course] to a JSON string.
  String toJson() => json.encode(toMap());
}
