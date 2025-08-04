import 'dart:convert';

class Review {
  String? userName;
  String? profilePicture;
  double? rating;
  String? comment;
  String? createdAt;

  Review({
    this.userName,
    this.profilePicture,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory Review.fromMap(Map<String, dynamic> data) => Review(
        userName: data['user_name'] as String?,
        profilePicture: data['profile_picture'] as String?,
        rating: data['rating'] as double?,
        comment: data['comment'] as String?,
        createdAt: data['created_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'user_name': userName,
        'profile_picture': profilePicture,
        'rating': rating,
        'comment': comment,
        'created_at': createdAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Review].
  factory Review.fromJson(String data) {
    return Review.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Review] to a JSON string.
  String toJson() => json.encode(toMap());
}
