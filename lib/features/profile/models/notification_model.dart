import 'dart:convert';

class NotificationModel {
  int? id;
  bool? isSeen;
  String? content;
  String? image;
  String? createdAt;
  String? createdAtHuman;

  NotificationModel({
    this.id,
    this.isSeen,
    this.content,
    this.image,
    this.createdAt,
    this.createdAtHuman,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'] as int?,
      isSeen: data['is_seen'] as bool?,
      content: data['content'] as String?,
      image: data['image'] as String?,
      createdAt: data['created_at'] as String?,
      createdAtHuman: data['created_at_human'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'is_seen': isSeen,
        'content': content,
        'image': image,
        'created_at': createdAt,
        'created_at_human': createdAtHuman,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotificationModel].
  factory NotificationModel.fromJson(String data) {
    return NotificationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NotificationModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
