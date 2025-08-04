import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:uuid/uuid.dart';

class AudioViewWidget extends ConsumerStatefulWidget {
  const AudioViewWidget({super.key});

  @override
  ConsumerState<AudioViewWidget> createState() => _AudioViewWidgetState();
}

class _AudioViewWidgetState extends ConsumerState<AudioViewWidget> {
  late String messageId;
  @override
  void initState() {
    super.initState();
    messageId = const Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioPlayerControllerProvider);
    final playerController = ref.watch(audioPlayerControllerProvider.notifier);
    final recordingState = ref.watch(audioRecorderControllerProvider);
    final audioTrackState = audioState?.audioStates[messageId];
    return Row(
      children: [
        Flexible(
          flex: 6,
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xffE0F0FE)
                  .withOpacity(context.isDarkMode ? 0.2 : 1),
              borderRadius: BorderRadius.all(
                Radius.circular(30.r),
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (audioTrackState?.isPlaying == true) {
                              print('pausing audio sdfsfdsdfsfdsdfsdfsdf');
                              // playerController.stopAudio(messageId: messageId);
                              audioTrackState?.player.stop();
                            } else {
                              playerController.playAudio(
                                url: recordingState?.path,
                                isLocal: true,
                                messageId: messageId,
                              );
                            }
                          },
                          child: Icon(
                            audioTrackState?.isPlaying == true
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
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(10.w),
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.r),
            child: IconButton(
              onPressed: () {
                ref
                    .read(audioRecorderControllerProvider.notifier)
                    .removeAudio();
              },
              icon: Icon(
                Icons.close,
                color: context.textTheme.bodyLarge?.color!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
