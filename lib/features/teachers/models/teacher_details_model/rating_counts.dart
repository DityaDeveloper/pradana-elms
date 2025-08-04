import 'dart:convert';

class RatingCounts {
  int? rating1;
  int? rating2;
  int? rating3;
  int? rating4;
  int? rating5;

  RatingCounts({
    this.rating1,
    this.rating2,
    this.rating3,
    this.rating4,
    this.rating5,
  });

  factory RatingCounts.fromMap(Map<String, dynamic> data) => RatingCounts(
        rating1: data['rating_1'] as int?,
        rating2: data['rating_2'] as int?,
        rating3: data['rating_3'] as int?,
        rating4: data['rating_4'] as int?,
        rating5: data['rating_5'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'rating_1': rating1,
        'rating_2': rating2,
        'rating_3': rating3,
        'rating_4': rating4,
        'rating_5': rating5,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RatingCounts].
  factory RatingCounts.fromJson(String data) {
    return RatingCounts.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RatingCounts] to a JSON string.
  String toJson() => json.encode(toMap());
}
