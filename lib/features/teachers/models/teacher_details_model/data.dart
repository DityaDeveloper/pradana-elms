import 'dart:convert';

import 'package:lms/features/home/models/home_model/course.dart';

import 'instructor.dart';
import 'pagination.dart';
import 'rating_counts.dart';
import 'review.dart';

class Data {
  Instructor? instructor;
  List<Course>? courses;
  double? averageRating;
  int? totalRating;
  RatingCounts? ratingCounts;
  List<Review>? reviews;
  Pagination? pagination;

  Data({
    this.instructor,
    this.courses,
    this.averageRating,
    this.totalRating,
    this.ratingCounts,
    this.reviews,
    this.pagination,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        instructor: data['instructor'] == null
            ? null
            : Instructor.fromMap(data['instructor'] as Map<String, dynamic>),
        courses: (data['courses'] as List<dynamic>?)
            ?.map((e) => Course.fromMap(e as Map<String, dynamic>))
            .toList(),
        averageRating: (data['average_rating'] as num?)?.toDouble(),
        totalRating: data['total_rating'] as int?,
        ratingCounts: data['rating_counts'] == null
            ? null
            : RatingCounts.fromMap(
                data['rating_counts'] as Map<String, dynamic>),
        reviews: (data['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromMap(e as Map<String, dynamic>))
            .toList(),
        pagination: data['pagination'] == null
            ? null
            : Pagination.fromMap(data['pagination'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'instructor': instructor?.toMap(),
        'courses': courses?.map((e) => e.toMap()).toList(),
        'average_rating': averageRating,
        'total_rating': totalRating,
        'rating_counts': ratingCounts?.toMap(),
        'reviews': reviews?.map((e) => e.toMap()).toList(),
        'pagination': pagination?.toMap(),
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
