import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/utils/date_time_utils.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/views/enums.dart';
import 'package:uuid/uuid.dart';

class ChatWithAudio extends ConsumerStatefulWidget {
  final MessageModel messageModel;
  const ChatWithAudio({
    super.key,
    required this.messageModel,
  });

  @override
  ConsumerState<ChatWithAudio> createState() => _AudioChatState();
}

class _AudioChatState extends ConsumerState<ChatWithAudio> {
  late String messageId;

  @override
  void initState() {
    super.initState();
    messageId = widget.messageModel.id?.toString() ?? const Uuid().v4();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioPlayerControllerProvider);
    final playerController = ref.read(audioPlayerControllerProvider.notifier);
    final audioTrackState = audioState?.audioStates[messageId];
    return Align(
      alignment: widget.messageModel.senderType == SenderType.instructor.name
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 1.3, // Maximum width
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: const EdgeInsets.all(8).r,
          decoration: BoxDecoration(
            color: widget.messageModel.senderType != SenderType.instructor.name
                ? const Color(0xffB9E2FE)
                    .withOpacity(context.isDarkMode ? 0.2 : 1)
                : context.cardColor,
            borderRadius:
                widget.messageModel.senderType != SenderType.student.name
                    ? BorderRadius.all(Radius.circular(16.r))
                        .copyWith(bottomLeft: Radius.zero)
                    : BorderRadius.all(Radius.circular(16.r))
                        .copyWith(bottomRight: Radius.zero),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (audioTrackState?.isPlaying == true) {
                          playerController.stopAudio(
                            messageId: messageId,
                            player: audioTrackState!.player,
                          );
                        } else {
                          // if any other audio is playing, stop it
                          audioState?.audioStates.forEach((key, value) {
                            if (key != messageId) {
                              playerController.stopAudio(
                                messageId: key,
                                player: value.player,
                              );
                            }
                          });
                          playerController.playAudio(
                            messageId: messageId,
                            url: widget.messageModel.media,
                            isLocal: widget.messageModel.media != null
                                ? widget.messageModel.media!.contains('http') ||
                                        widget.messageModel.media!
                                            .contains('https')
                                    ? false
                                    : true
                                : false,
                          );
                        }
                      },
                      child: Icon(
                        audioTrackState != null && audioTrackState.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 30,
                      ),
                    ),
                  ),
                  Gap(10.w),
                  Flexible(
                    flex: 6,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10.r),
                      value: audioTrackState != null &&
                              audioTrackState.duration > 0
                          ? audioTrackState.currentPosition /
                              audioTrackState.duration
                          : 0,
                      backgroundColor: const Color(0xffE0F0FE),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  DateTimeUtils()
                      .formatMessageDateTime(widget.messageModel.sentAt!),
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
