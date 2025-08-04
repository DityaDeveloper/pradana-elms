import 'dart:convert';

import 'semester.dart';

class Data {
  dynamic video;
  String? thumbnail;
  List<Semester>? semesters;

  Data({this.video, this.thumbnail, this.semesters});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        video: data['video'] as dynamic,
        thumbnail: data['thumbnail'] as String?,
        semesters: (data['semesters'] as List<dynamic>?)
            ?.map((e) => Semester.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'video': video,
        'thumbnail': thumbnail,
        'semesters': semesters?.map((e) => e.toMap()).toList(),
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
