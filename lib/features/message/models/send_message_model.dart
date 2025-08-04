import 'package:lms/features/message/models/question_details_model.dart';

class SendMessageModel {
  final int instructorId;
  final String? text;
  final String type;
  final String? media;
  final String? senderType;
  final QuestionDetailsModel? questionDetailsModel;

  SendMessageModel({
    required this.instructorId,
    this.text,
    required this.type,
    this.media,
    this.questionDetailsModel,
    this.senderType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'instructor_id': instructorId,
      'text': text,
      'type': type,
      'media': media,
      'sender_type': senderType,
      'question_details': questionDetailsModel?.toMap(),
    };
  }
}
