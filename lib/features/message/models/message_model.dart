import 'dart:convert';

import 'package:lms/features/message/models/question_details_model.dart';

class MessageModel {
  final int? id;
  final String senderType;
  final String? media;
  final String? text;
  final String? type;
  final DateTime? sentAt;
  final bool isNetworkImage;
  final QuestionDetailsModel? questionDetailsModel;
  MessageModel({
    this.id,
    required this.senderType,
    this.media,
    this.text,
    this.type,
    DateTime? sentAt,
    this.isNetworkImage = true,
    this.questionDetailsModel,
  }) : sentAt = sentAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'question_details': questionDetailsModel?.toMap(),
      'sender_type': senderType,
      'media': media,
      'type': type,
      'sent_at': sentAt?.toIso8601String(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? int.tryParse(map['id'].toString()) ?? 0 : null,
      text: map['text'] != null ? map['text'] as String : null,
      questionDetailsModel: map['question_details'] is Map
          ? map['question_details'] != null
              ? QuestionDetailsModel.fromMap(
                  map['question_details'] as Map<String, dynamic>)
              : null
          : null,
      senderType: map['sender_type'],
      type: map['type'] != null ? map['type'] as String : null,
      media: map['media'] != null ? map['media'] as String : null,
      sentAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
