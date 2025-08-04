import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/date_time_utils.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/views/enums.dart';

class ChatWithMessage extends StatelessWidget {
  final MessageModel messageModel;
  const ChatWithMessage({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: messageModel.senderType == SenderType.instructor.name
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3,
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(8).r,
          decoration: BoxDecoration(
            color: messageModel.senderType != SenderType.instructor.name
                ? const Color(0xffB9E2FE)
                    .withOpacity(context.isDarkMode ? 0.2 : 1)
                : context.cardColor,
            borderRadius: messageModel.senderType == SenderType.student.name
                ? BorderRadius.all(Radius.circular(16.r))
                    .copyWith(bottomLeft: Radius.zero)
                : BorderRadius.all(Radius.circular(16.r))
                    .copyWith(bottomRight: Radius.zero),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageModel.text ?? '',
                textAlign: TextAlign.start,
                style: context.textTheme.bodyLarge,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  DateTimeUtils().formatMessageDateTime(messageModel.sentAt!),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
