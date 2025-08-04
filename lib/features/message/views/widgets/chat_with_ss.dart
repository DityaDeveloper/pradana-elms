import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/utils/date_time_utils.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/message/models/message_model.dart';

class ChatWithSS extends StatelessWidget {
  final MessageModel messageModel;
  const ChatWithSS({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.3,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color:
              const Color(0xffE0F0FE).withOpacity(context.isDarkMode ? 0.2 : 1),
          borderRadius: BorderRadius.all(Radius.circular(16.r)).copyWith(
            bottomRight: Radius.zero,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8).r,
              child: Column(children: [
                ...messageModel.questionDetailsModel!.toMap().entries.map(
                      (e) => lessonInfo(
                        title: e.key,
                        value: e.value,
                      ),
                    ),
              ]),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(8).r,
              decoration: BoxDecoration(
                color: const Color(0xffB9E2FE)
                    .withOpacity(context.isDarkMode ? 0.3 : 1),
              ),
              child: Column(
                children: [
                  // GestureDetector(
                  //   onTap: () => showDialog(
                  //       barrierDismissible: false,
                  //       context: context,
                  //       builder: (context) => FullScreenPhotoViewDialog(
                  //             image: messageModel.media!,
                  //           )),
                  //   child: Container(
                  //     height: 150.h,
                  //     width: double.infinity,
                  //     clipBehavior: Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12.r),
                  //     ),
                  //     child: messageModel.media == null
                  //         ? Container()
                  //         : messageModel.media!.contains("http")
                  //             ? Image.network(
                  //                 messageModel.media!,
                  //                 fit: BoxFit.cover,
                  //               )
                  //             : Image.file(
                  //                 File(messageModel.media!),
                  //                 fit: BoxFit.cover,
                  //               ),
                  //   ),
                  // ),
                  Gap(8.h),
                  Text(
                    messageModel.text!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateTimeUtils()
                          .formatMessageDateTime(messageModel.sentAt!),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row lessonInfo({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                ":",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        const Gap(8),
        Expanded(
          flex: 7,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
