import 'dart:convert';

class Course {
  int? id;
  int? gradeId;
  String? grade;
  String? title;
  String? thumbnail;
  dynamic video;
  double? regularPrice;
  double? price;
  int? videoCount;
  int? noteCount;
  int? examCount;
  bool? isEnrolled;
  bool? isCompleted;
  bool? isReviewed;
  bool? canReview;
  int? isFree;
  bool? isLocked;

  Course({
    this.id,
    this.gradeId,
    this.grade,
    this.title,
    this.thumbnail,
    this.video,
    this.regularPrice,
    this.price,
    this.videoCount,
    this.noteCount,
    this.examCount,
    this.isEnrolled,
    this.isCompleted,
    this.isReviewed,
    this.canReview,
    this.isFree,
    this.isLocked,
  });

  factory Course.fromMap(Map<String, dynamic> data) => Course(
        id: data['id'] as int?,
        gradeId: data['grade_id'] as int?,
        grade: data['grade'] as String?,
        title: data['title'] as String?,
        thumbnail: data['thumbnail'] as String?,
        video: data['video'] as dynamic,
        regularPrice: (data['regular_price'] as num?)?.toDouble(),
        price: (data['price'] as num?)?.toDouble(),
        videoCount: data['video_count'] as int?,
        noteCount: data['note_count'] as int?,
        examCount: data['exam_count'] as int?,
        isEnrolled: data['is_enrolled'] as bool?,
        isReviewed: data['is_reviewed'] as bool?,
        isFree: data['is_free'] as int?,
        isLocked: data['is_locked'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'grade_id': gradeId,
        'grade': grade,
        'title': title,
        'thumbnail': thumbnail,
        'video': video,
        'regular_price': regularPrice,
        'price': price,
        'video_count': videoCount,
        'note_count': noteCount,
        'exam_count': examCount,
        'is_enrolled': isEnrolled,
        'is_reviewed': isReviewed,
        'is_free': isFree,
        'is_locked': isLocked,
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
