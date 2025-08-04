import 'dart:convert';

class Instructor {
  int? id;
  String? name;
  String? profilePicture;
  String? title;
  String? about;
  int? isFeatured;
  String? joiningDate;
  double? averageRating;
  int? reviewsCount;
  int? courseCount;
  int? studentCount;
  int? videoCount;

  Instructor({
    this.id,
    this.name,
    this.profilePicture,
    this.title,
    this.about,
    this.isFeatured,
    this.joiningDate,
    this.averageRating,
    this.reviewsCount,
    this.courseCount,
    this.studentCount,
    this.videoCount,
  });

  factory Instructor.fromMap(Map<String, dynamic> data) => Instructor(
        id: data['id'] as int?,
        name: data['name'] as String?,
        profilePicture: data['profile_picture'] as String?,
        title: data['title'] as String?,
        about: data['about'] as String?,
        isFeatured: data['is_featured'] as int?,
        joiningDate: data['joining_date'] as String?,
        averageRating: (data['average_rating'] as num?)?.toDouble(),
        reviewsCount: data['reviews_count'] as int?,
        courseCount: data['course_count'] as int?,
        studentCount: data['student_count'] as int?,
        videoCount: data['video_count'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'profile_picture': profilePicture,
        'title': title,
        'about': about,
        'is_featured': isFeatured,
        'joining_date': joiningDate,
        'average_rating': averageRating,
        'reviews_count': reviewsCount,
        'course_count': courseCount,
        'student_count': studentCount,
        'video_count': videoCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Instructor].
  factory Instructor.fromJson(String data) {
    return Instructor.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Instructor] to a JSON string.
  String toJson() => json.encode(toMap());
}
