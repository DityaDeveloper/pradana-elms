import 'dart:convert';

import 'course.dart';
import 'semester.dart';

class Data {
  bool? certificateAvailable;
  int? overallProgress;
  List<Semester>? semesters;
  List<Course>? courses;
  int? currentPage;
  int? itemsPerPage;

  Data({
    this.certificateAvailable,
    this.overallProgress,
    this.semesters,
    this.courses,
    this.currentPage,
    this.itemsPerPage,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        certificateAvailable: data['certificate_available'] as bool?,
        overallProgress: data['overall_progress'] as int?,
        semesters: (data['semesters'] as List<dynamic>?)
            ?.map((e) => Semester.fromMap(e as Map<String, dynamic>))
            .toList(),
        courses: (data['courses'] as List<dynamic>?)
            ?.map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList(),
        currentPage: data['current_page'] as int?,
        itemsPerPage: data['items_per_page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'certificate_available': certificateAvailable,
        'overall_progress': overallProgress,
        'semesters': semesters?.map((e) => e.toMap()).toList(),
        'courses': courses?.map((e) => e.toMap()).toList(),
        'current_page': currentPage,
        'items_per_page': itemsPerPage,
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
