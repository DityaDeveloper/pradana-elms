import 'package:flutter/material.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/views/media_enums.dart';
import 'package:lms/features/message/views/widgets/chat_with_audio.dart';
import 'package:lms/features/message/views/widgets/chat_with_image.dart';
import 'package:lms/features/message/views/widgets/chat_with_message.dart';
import 'package:lms/features/message/views/widgets/chat_with_ss.dart';

class ChatWidget extends StatelessWidget {
  final MessageModel messageModel;

  const ChatWidget({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    if (messageModel.questionDetailsModel != null) {
      return ChatWithSS(
        messageModel: messageModel,
      );
    }
    if (messageModel.type == MediaEnums.image.name &&
        messageModel.questionDetailsModel == null) {
      return ChatWithImage(
        messageModel: messageModel,
      );
    }
    if (messageModel.type == MediaEnums.audio.name) {
      return ChatWithAudio(
        messageModel: messageModel,
      );
    }

    return ChatWithMessage(
      messageModel: messageModel,
    );
  }
}
