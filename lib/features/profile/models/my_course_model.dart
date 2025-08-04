import 'dart:convert';

class MyCourseModel {
  int? id;
  String? title;
  String? thumbnail;
  int? videoCount;
  bool? isSpecial;
  bool? certificateAvailable;
  int? overallProgress;

  MyCourseModel({
    this.id,
    this.title,
    this.thumbnail,
    this.videoCount,
    this.isSpecial,
    this.certificateAvailable,
    this.overallProgress,
  });

  factory MyCourseModel.fromMap(Map<String, dynamic> data) => MyCourseModel(
        id: data['id'] as int?,
        title: data['title'] as String?,
        thumbnail: data['thumbnail'] as String?,
        videoCount: data['video_count'] as int?,
        isSpecial: data['is_special'] as bool?,
        certificateAvailable: data['certificate_available'] as bool?,
        overallProgress: data['overall_progress'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'thumbnail': thumbnail,
        'video_count': videoCount,
        'is_special': isSpecial,
        'certificate_available': certificateAvailable,
        'overall_progress': overallProgress,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MyCourseModel].
  factory MyCourseModel.fromJson(String data) {
    return MyCourseModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MyCourseModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
