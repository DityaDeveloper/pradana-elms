import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/views/enums.dart';
import 'package:lms/features/semesters/models/chapter_model/lesson.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideoPlayerScreen extends ConsumerStatefulWidget {
  const LessonVideoPlayerScreen({
    super.key,
    required this.semesterTitle,
    required this.lessonList,
    required this.chapterId,
    required this.teacherId,
    required this.subjectId,
    required this.chapterTitle,
    this.selectedPassLesson,
  });
  final String semesterTitle;
  final List<Lesson> lessonList;
  final int chapterId;
  final int teacherId;
  final int subjectId;
  final String chapterTitle;
  final Lesson? selectedPassLesson;
  @override
  ConsumerState<LessonVideoPlayerScreen> createState() =>
      _LessonVideoPlayerScreenState();
}

class _LessonVideoPlayerScreenState
    extends ConsumerState<LessonVideoPlayerScreen> {
  late Lesson currentLesson;

  @override
  void initState() {
    super.initState();
    currentLesson = widget.selectedPassLesson ?? widget.lessonList.first;
    ref.read(lessonViewProvider(
      chapterId: widget.chapterId,
      lessonId: widget.lessonList.first.id ?? 0,
      teacherId: widget.teacherId,
    ));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(messageControllerProvider.notifier).getMessages(
            instuctorId: widget.teacherId,
            page: 1,
          );
    });
    ref.read(messageControllerProvider);
    // if lesson has one item then refresh the lesson
    if (widget.lessonList.length == 1) {
      refreshLesson(widget.subjectId, widget.teacherId);
    }
  }

  // refresh the lesson
  void refreshLesson(int subjectId, int teacherId) {
    ref.refresh(
        semesterListProvider(subjectId: subjectId, teacherId: teacherId));
  }

  final GlobalKey<PlayerWidgetState> playerWidgetKey =
      GlobalKey<PlayerWidgetState>();

  String renderField({required String type, required String source}) {
    if (type == 'video' && source == 'upload') {
      return 'normalVideo';
    } else if (type == 'video' && source == 'youtube') {
      return "youtube";
    } else if (type == 'audio' && source == 'upload') {
      return 'audio';
    } else {
      return 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Widget rebuild");
    final fieldType = renderField(
      type: currentLesson.type ?? '',
      source: currentLesson.source ?? '',
    );
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(),
          Gap(5.h),
          // _PlayerWidget(
          //   key: playerWidgetKey,
          //   videoUrl: currentLesson.media ?? '',
          // ),
          switch (fieldType) {
            'normalVideo' => _PlayerWidget(
                key: playerWidgetKey,
                videoUrl: currentLesson.media ?? '',
              ),
            'audio' => _PlayerWidget(
                key: playerWidgetKey,
                videoUrl: currentLesson.media ?? '',
              ),
            'youtube' => YoutubePlayerWidget(
                // youtubeUrl: 'https://youtu.be/A3ltMaM6noM',
                youtubeUrl: currentLesson.mediaLink ?? '',
              ),
            _ => const Center(
                child: Text('Document detected. Cannot play this content.'),
              )
          },
          Gap(8.h),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
            width: double.infinity,
            color: context.cardColor,
            child: Text(
              currentLesson.title ?? '',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 60.h),
              child: Column(
                children: List.generate(
                  widget.lessonList.length,
                  (index) {
                    final lessonId = widget.lessonList[index].id;
                    return Container(
                      padding: const EdgeInsets.all(12).r,
                      margin:
                          const EdgeInsets.only(top: 10, right: 16, left: 16).r,
                      decoration: BoxDecoration(
                        color: lessonId == currentLesson.id
                            ? Color(
                                context.isDarkMode ? 0xff3D3D3D : 0xffF0F8FF)
                            : context.cardColor,
                        borderRadius: BorderRadius.circular(10).r,
                        border: lessonId == currentLesson.id
                            ? Border.all(color: AppColors.primaryLightColor)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentLesson = widget.lessonList[index];
                          });
                          ref.read(
                            lessonViewProvider(
                              chapterId: widget.chapterId,
                              lessonId: widget.lessonList[index].id ?? 0,
                              teacherId: widget.teacherId,
                            ),
                          );
                          // if lesson click the last item then refresh the lesson
                          if (index == widget.lessonList.length - 1) {
                            refreshLesson(widget.subjectId, widget.teacherId);
                          }
                        },
                        child: Row(
                          children: [
                            lessonId == currentLesson.id
                                ? ref.watch(isVideoPlayingProvider) == true
                                    ? const Icon(
                                        Icons.pause,
                                        color: AppColors.primaryLightColor,
                                      )
                                    : const Icon(
                                        Icons.play_arrow,
                                        color: AppColors.primaryLightColor,
                                      )
                                : Text(
                                    (index + 1).toString(),
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            Gap(8.w),
                            Container(
                              height: 75.r,
                              width: 75.r,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12).r,
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.lessonList[index].thumbnailLink ??
                                        '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gap(8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.lessonList[index].title ?? '',
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(4.h),
                                  Text(
                                    "${widget.lessonList[index].course} | ${widget.lessonList[index].instructor}",
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Gap(4.h),
                                  Text(
                                    widget.lessonList[index].duration ?? '',
                                    style:
                                        context.textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryLightColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: Hive.box(AppConstants.authBox).listenable(),
          builder: (context, Box box, child) {
            final isChatEnabled =
                box.get(AppConstants.isChatEnabled, defaultValue: false);
            return isChatEnabled == false
                ? const SizedBox()
                : Material(
                    borderRadius: BorderRadius.circular(32).r,
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32).r,
                      onTap: () async {
                        await _handleOnTap(context);
                      },
                      child: Container(
                        height: 45.r,
                        padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10)
                            .r,
                        decoration: BoxDecoration(
                          color: context.cardColor,
                          borderRadius: BorderRadius.circular(32).r,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Assets.svgs.messageQuestion,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap(8.w),
                            Text(
                              "Ask Teacher",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  Future<void> _handleOnTap(BuildContext context) async {
    final position = playerWidgetKey.currentState?.stopPlyer();

    // final String? screenshotPath =
    //     await ImagePickerUtils().captureScreenshot(key: repaintBoundaryKey);

    ref.read(questionDetailsControllerProvider.notifier).update(
          (state) => state.copyWith(time: position),
        );

    MessageModel messageModel = MessageModel(
      // media: screenshotPath,
      media: "",
      senderType: SenderType.student.name,
      text: 'I am not clear about this topic. Please help me',
      questionDetailsModel: ref.read(questionDetailsControllerProvider),
    );
    // if (screenshotPath != null) {
    ref
        .read(messageControllerProvider.notifier)
        .addMessage(messageModel, widget.teacherId);
    if (context.mounted) {
      context.push(Routes.messageScreen, extra: {
        'teacherId': widget.teacherId,
        'senderType': SenderType.student
      });
    }
    // }
  }

  CommonAppbarWithBg _headerSection() {
    return CommonAppbarWithBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.semesterTitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            widget.chapterTitle,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _PlayerWidget extends ConsumerStatefulWidget {
  const _PlayerWidget({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  ConsumerState<_PlayerWidget> createState() => PlayerWidgetState();
}

class PlayerWidgetState extends ConsumerState<_PlayerWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  String demoVideo =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializePlayer(widget.videoUrl);
  }

  Future<void> _initializePlayer(String url) async {
    _videoPlayerController = VideoPlayerController.network(url);
    await _videoPlayerController.initialize();
    // Detect if video is playing or not
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.isPlaying) {
        debugPrint("Video is playing");
        ref.read(isVideoPlayingProvider.notifier).state = true;
      } else {
        debugPrint("Video is not playing");
        ref.read(isVideoPlayingProvider.notifier).state = false;
      }
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showOptions: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey,
      ),
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // App is in the background
      _videoPlayerController.pause();
    } else if (state == AppLifecycleState.resumed) {
      // App has come back to the foreground
      // _videoPlayerController.play();
    }
  }

  @override
  void didUpdateWidget(covariant _PlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoUrl != oldWidget.videoUrl) {
      _changeVideoSource(widget.videoUrl);
    }
  }

  Future<void> _changeVideoSource(String videoUrl) async {
    // Pause and dispose of the old controllers
    await _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _chewieController?.dispose();

    // Initialize new controllers with the new video URL
    await _initializePlayer(videoUrl);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    // Reset the app orientation when exiting the video screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("videoUrlddd: ${widget.videoUrl}");
    return Column(
      children: [
        RepaintBoundary(
          key: repaintBoundaryKey,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : const Center(child: CircularProgressIndicator()),
          ),
        ),

        // // Button to capture the screenshot
      ],
    );
  }

  // stop player and return current position
  String stopPlyer({required}) {
    _videoPlayerController.pause();

    Duration position = _videoPlayerController.value.position;
    final String formattedTime = _formatDuration(position);

    return formattedTime;
  }
}

// Function to format the duration
String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));

  return '$hours$minutes:$seconds';
}

final GlobalKey repaintBoundaryKey = GlobalKey();

class YoutubePlayerWidget extends ConsumerStatefulWidget {
  final String youtubeUrl;

  const YoutubePlayerWidget({super.key, required this.youtubeUrl});

  @override
  ConsumerState<YoutubePlayerWidget> createState() =>
      _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends ConsumerState<YoutubePlayerWidget>
    with WidgetsBindingObserver {
  late YoutubePlayerController _controller;
  bool _isNavigatingToFullScreen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen && !_isNavigatingToFullScreen) {
        _isNavigatingToFullScreen = true; // Set the flag
        _controller.pause();
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) =>
                FullscreenYoutubeWidget(url: widget.youtubeUrl),
          ),
        )
            .then((_) {
          _isNavigatingToFullScreen = false;
        });
      }
      if (_controller.value.isPlaying) {
        ref.read(isVideoPlayingProvider.notifier).state = true;
      } else {
        ref.read(isVideoPlayingProvider.notifier).state = false;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
    );
  }
}

class FullscreenYoutubeWidget extends StatefulWidget {
  final String url;

  const FullscreenYoutubeWidget({
    super.key,
    required this.url,
  });

  @override
  State<FullscreenYoutubeWidget> createState() =>
      _FullscreenYoutubeWidgetState();
}

class _FullscreenYoutubeWidgetState extends State<FullscreenYoutubeWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(() {
        // if (_controller.value.isFullScreen) {
        //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        //       overlays: []);
        // } else {
        //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        //       overlays: []);
        // }
      });
  }

  @override
  void dispose() {
    // Reset orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // // show status bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}

// ...existing code...

// class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget>
//     with WidgetsBindingObserver {
//   late YoutubePlayerController _controller;
//   bool _isNavigatingToFullScreen = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '',
//       flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
//     );

//     _controller.addListener(() {
//       if (_controller.value.isFullScreen && !_isNavigatingToFullScreen) {
//         _isNavigatingToFullScreen = true;
//         Navigator.of(context)
//             .push(
//           MaterialPageRoute(
//             builder: (_) => FullscreenYoutubeWidget(controller: _controller),
//           ),
//         )
//             .then((_) {
//           _isNavigatingToFullScreen = false;
//         });
//       }
//     });
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.paused) {
//       _controller.pause();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//       ),
//     );
//   }
// }

// class FullscreenYoutubeWidget extends StatefulWidget {
//   final YoutubePlayerController controller;
//   const FullscreenYoutubeWidget({super.key, required this.controller});

//   @override
//   State<FullscreenYoutubeWidget> createState() =>
//       _FullscreenYoutubeWidgetState();
// }

// class _FullscreenYoutubeWidgetState extends State<FullscreenYoutubeWidget> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//     widget.controller.play();
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: YoutubePlayer(
//         controller: widget.controller,
//         showVideoProgressIndicator: true,
//       ),
//     );
//   }
// }
