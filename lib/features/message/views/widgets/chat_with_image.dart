import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/utils/date_time_utils.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/views/enums.dart';
import 'package:lms/features/message/views/widgets/full_screen_photo_view_dialog.dart';

class ChatWithImage extends StatelessWidget {
  final MessageModel messageModel;
  const ChatWithImage({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: messageModel.senderType == SenderType.instructor.name
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          color:
              const Color(0xffB9E2FE).withOpacity(context.isDarkMode ? 0.2 : 1),
          borderRadius: messageModel.senderType == SenderType.student.name
              ? BorderRadius.all(Radius.circular(16.r))
                  .copyWith(bottomLeft: Radius.zero)
              : BorderRadius.all(Radius.circular(16.r))
                  .copyWith(bottomRight: Radius.zero),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return FullScreenPhotoViewDialog(
                    image: messageModel.media!,
                  );
                },
              ),
              child: Container(
                height: 150.h,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: messageModel.media != null
                    ? messageModel.media!.contains("http") ||
                            messageModel.media!.contains("https")
                        ? Image.network(
                            messageModel.media!,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(messageModel.media!),
                            fit: BoxFit.cover,
                          )
                    : Container(
                        child: const Text("No Image"),
                      ),
              ),
            ),
            Gap(8.h),
            Text(
              messageModel.text ?? "",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
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
    );
  }
}
