import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/image_picker_utils.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/views/enums.dart';
import 'package:lms/features/message/views/media_enums.dart';
import 'package:lms/features/message/views/widgets/audio_view_widget.dart';
import 'package:lms/features/message/views/widgets/chat_widget.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';

class MessageScreen extends ConsumerStatefulWidget {
  final int teacherId;
  final SenderType senderType;

  const MessageScreen({
    super.key,
    required this.teacherId,
    required this.senderType,
  });

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _requestMicrophonePermission();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                const _HeaderWidget(),
                Consumer(builder: (context, ref, _) {
                  final messageList = ref.watch(messageControllerProvider);
                  _scrollDown();
                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        final messageModel = messageList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: ChatWidget(messageModel: messageModel),
                        );
                      },
                    ),
                  );
                }),
                MessageSendSection(
                  teacherId: widget.teacherId,
                  senderType: widget.senderType,
                )
              ],
            ),
            // if (ref.watch(showDownButtonProvider))
            //   Positioned(
            //     top: 150.h,
            //     left: 50.w,
            //     right: 50.w,
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 20).r,
            //       child: GestureDetector(
            //         onTap: () {
            //           ref.read(showDownButtonProvider.notifier).state = false;
            //           _scrollController.animateTo(
            //             _scrollController.position.minScrollExtent,
            //             duration: const Duration(milliseconds: 500),
            //             curve: Curves.easeInOut,
            //           );
            //         },
            //         child: CircleAvatar(
            //           radius: 24.r,
            //           backgroundColor: Colors.black,
            //           child: const Icon(
            //             Icons.keyboard_arrow_down,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  void _scrollDown() {
    if (ref.read(messageControllerProvider).isEmpty) return;
    // Check if the user is at the top or actively scrolling up
    if (_scrollController.hasClients &&
        _scrollController.position.pixels > 0 &&
        !_isUserScrollingUp) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _isUserScrollingUp = false;

  void _onScroll() {
    final scrollPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    // Detect if the user is scrolling up
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _isUserScrollingUp = false;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _isUserScrollingUp = true;
      ref.read(showDownButtonProvider.notifier).state = true;
    }

    // Load more messages if scrolled to the end
    if (scrollPosition >= maxScrollExtent) {
      fetchMoreMessages();
    }
  }

  int page = 2;
  void fetchMoreMessages() {
    if (ref.read(messageControllerProvider).length <
        ref.read(totalMessageCountProvider)) {
      ref.read(messageControllerProvider.notifier).getMessages(
            instuctorId: widget.teacherId,
            page: page++,
          );
    }
    return;
  }

  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
      return;
    }

    if (status.isGranted) {
      // Permission granted, you can now access the microphone
      debugPrint("Microphone permission granted");
    } else if (status.isDenied) {
      // Permission denied
      debugPrint("Microphone permission denied");
    } else if (status.isPermanentlyDenied) {
      print("Microphone permission permanently denied");
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return CommonAppbarWithBg(
      child: ValueListenableBuilder(
          valueListenable: Hive.box(AppConstants.authBox).listenable(),
          builder: (context, box, _) {
            return Row(
              children: [
                Text(
                  box.get(AppConstants.hasParentLoggedIn, defaultValue: false)
                      ? S.of(context).askTeacher
                      : box.get(AppConstants.userData,
                              defaultValue: null)?['name'] ??
                          '',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                // if (box.get(AppConstants.hasParentLoggedIn,
                //         defaultValue: false) ==
                //     true)
                //   Container(
                //     height: 42.h,
                //     width: 42.w,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //         image: CachedNetworkImageProvider(
                //           box.get(AppConstants.userData,
                //                   defaultValue: null)?['profile_picture'] ??
                //               '',
                //         ),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   )
              ],
            );
          }),
    );
  }
}

class MessageSendSection extends ConsumerStatefulWidget {
  final int teacherId;
  final SenderType senderType;
  const MessageSendSection({
    super.key,
    required this.teacherId,
    required this.senderType,
  });

  @override
  ConsumerState<MessageSendSection> createState() => _MessageSendSectionState();
}

class _MessageSendSectionState extends ConsumerState<MessageSendSection> {
  bool isWriting = false;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final audioRecordingState = ref.watch(audioRecorderControllerProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10).r,
      color: context.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (audioRecordingState?.path != null) const AudioViewWidget(),
          if (ref.watch(pickedImageControllerProvider) != null)
            _PickedImagePreviewWidget(
              ref.watch(pickedImageControllerProvider),
              () {
                ref.read(pickedImageControllerProvider.notifier).removeImage();
              },
            ),
          Row(
            children: [
              Visibility(
                visible: !isWriting,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          // // requestMicrophonePermission();
                          if (audioRecordingState.isRecording) {
                            ref
                                .read(audioRecorderControllerProvider.notifier)
                                .stopRecording();
                          } else {
                            if (ref
                                    .read(audioRecorderControllerProvider)
                                    ?.path !=
                                null) {
                              ref
                                  .read(
                                      audioRecorderControllerProvider.notifier)
                                  .removeAudio();
                            } else {
                              ref
                                  .read(
                                      audioRecorderControllerProvider.notifier)
                                  .startRecording();
                            }
                          }
                        },
                        child: SvgPicture.asset(
                          Assets.svgs.mic,
                          colorFilter: ColorFilter.mode(
                            audioRecordingState!.isRecording
                                ? Colors.red
                                : context.textTheme.bodyLarge!.color!,
                            BlendMode.srcIn,
                          ),
                        )),
                    Gap(8.w),
                    GestureDetector(
                      onTap: () async {
                        File? image =
                            await ImagePickerUtils().pickImageFromGallery();
                        String? path = image?.path;
                        if (path != null) {
                          ref
                              .read(pickedImageControllerProvider.notifier)
                              .selectImage(path);
                        }
                      },
                      child: SvgPicture.asset(
                        Assets.svgs.camera,
                        colorFilter: ColorFilter.mode(
                          context.textTheme.bodyLarge!.color!,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Gap(8.w),
                  ],
                ),
              ),
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      isWriting = value.isNotEmpty;
                    });
                  },
                  controller: controller,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: S.of(context).writeyourask,
                    hintStyle: context.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xff888888),
                    ),
                    fillColor: context.chipsColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ).r,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Gap(8.w),
              Consumer(builder: (context, ref, _) {
                return GestureDetector(
                  onTap: () => _onTapSendMessage(ref),
                  child: SvgPicture.asset(Assets.svgs.send),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapSendMessage(WidgetRef ref) async {
    if (ref.read(audioRecorderControllerProvider)?.isRecording == true) {
      ref.read(audioRecorderControllerProvider.notifier).stopRecording();
    } else {
      print('Sender Type: ${widget.senderType.name}');
      MessageModel message = MessageModel(
        senderType: widget.senderType.name,
        type: getMediaType(),
        media: await getFilePath(),
        text: controller.text,
      );

      ref.read(messageControllerProvider.notifier).addMessage(
            message,
            widget.teacherId,
          );
      ref.read(pickedImageControllerProvider.notifier).removeImage();
      ref.read(audioRecorderControllerProvider.notifier).removeAudio();
      controller.clear();
      setState(() {
        isWriting = false;
      });
    }
  }

  String? getMediaType() {
    if (ref.read(pickedImageControllerProvider) != null) {
      return MediaEnums.image.name;
    } else if (ref.watch(audioRecorderControllerProvider)?.path != null) {
      return MediaEnums.audio.name;
    } else {
      return MediaEnums.text.name;
    }
  }

  Future<String?> getFilePath() async {
    if (ref.read(pickedImageControllerProvider) != null) {
      return ref.read(pickedImageControllerProvider)!;
    } else if (ref.read(audioRecorderControllerProvider)?.path != null) {
      return ref.watch(audioRecorderControllerProvider)?.path;
    } else {
      return null;
    }
  }
}

class _PickedImagePreviewWidget extends StatelessWidget {
  final String? path;
  final VoidCallback onTap;
  const _PickedImagePreviewWidget(
    this.path,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.file(
              height: 100.h,
              width: 100.w,
              fit: BoxFit.cover,
              File(path!),
            ),
          ),
        ),
        Positioned(
          top: 2.h,
          right: 2.w,
          child: GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 12.r,
              backgroundColor: Colors.black.withOpacity(0.2),
              child: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
