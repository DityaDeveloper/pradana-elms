import 'dart:convert';

import 'course.dart';
import 'instructor.dart';
import 'slider.dart';

class Data {
  List<Slider>? sliders;
  List<Instructor>? instructors;
  List<Course>? courses;

  Data({this.sliders, this.instructors, this.courses});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        sliders: (data['sliders'] as List<dynamic>?)
            ?.map((e) => Slider.fromMap(e as Map<String, dynamic>))
            .toList(),
        instructors: (data['instructors'] as List<dynamic>?)
            ?.map((e) => Instructor.fromMap(e as Map<String, dynamic>))
            .toList(),
        courses: (data['courses'] as List<dynamic>?)
            ?.map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'sliders': sliders?.map((e) => e.toMap()).toList(),
        'instructors': instructors?.map((e) => e.toMap()).toList(),
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
