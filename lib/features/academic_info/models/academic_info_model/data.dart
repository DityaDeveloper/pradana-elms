import 'dart:convert';

import 'package:lms/features/home/models/home_model/course.dart';

import 'country.dart';
import 'grade.dart';
import 'school_type.dart';

class Data {
  List<Grade>? grades;
  List<SchoolType>? schoolTypes;
  List<Country>? countries;
  List<Course>? courses;

  Data({this.grades, this.schoolTypes, this.countries, this.courses});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        grades: (data['grades'] as List<dynamic>?)
            ?.map((e) => Grade.fromMap(e as Map<String, dynamic>))
            .toList(),
        schoolTypes: (data['school_types'] as List<dynamic>?)
            ?.map((e) => SchoolType.fromMap(e as Map<String, dynamic>))
            .toList(),
        countries: (data['countries'] as List<dynamic>?)
            ?.map((e) => Country.fromMap(e as Map<String, dynamic>))
            .toList(),
        courses: (data['courses'] as List<dynamic>?)
            ?.map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'grades': grades?.map((e) => e.toMap()).toList(),
        'school_types': schoolTypes?.map((e) => e.toMap()).toList(),
        'countries': countries?.map((e) => e.toMap()).toList(),
        'courses': courses?.map((e) => e.toMap()).toList(),
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
