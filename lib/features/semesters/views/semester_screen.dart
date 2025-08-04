import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/semesters/views/widgets/chaptes_sections.dart';
import 'package:lms/features/semesters/views/widgets/rate_teacher_dialog.dart';
import 'package:lms/features/semesters/views/widgets/semester_exam.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';
import 'package:video_player/video_player.dart';

class SemesterScreen extends ConsumerWidget {
  const SemesterScreen({
    super.key,
    required this.subjectName,
    required this.teacherName,
    required this.subjectId,
    required this.teacherId,
  });
  final String subjectName;
  final String teacherName;
  final int subjectId;
  final int teacherId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppConstants.authBox).listenable(),
      builder: (context, box, _) {
        final isAuth =
            box.get(AppConstants.authToken, defaultValue: null) == null
                ? false
                : true;
        return Scaffold(
          backgroundColor: context.isDarkMode
              ? AppColors.darkScaffoldColor
              : const Color(0xffF6F6F6),
          body: Column(
            children: [
              _headerSection(),
              // Semester List
              SemesterListSection(
                subjectId: subjectId,
                teacherId: teacherId,
              ),
              Gap(8.h),
              ref
                  .watch(chapterAndExamListProvider(
                      subjectId: subjectId, teacherId: teacherId))
                  .when(
                data: (data) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                                data!.data!.chapters!.length, (index) {
                              final chapter = data.data!.chapters![index];
                              return Column(
                                children: [
                                  ChaptersSection(
                                    title: chapter.title ?? '',
                                    lessonList: chapter.lessons ?? [],
                                    resources: chapter.resources ?? [],
                                    chapterId: chapter.id ?? 0,
                                    teacherId: teacherId,
                                    subjectId: subjectId,
                                  ),
                                  Gap(8.h),
                                ],
                              );
                            }),
                          ),
                          Column(
                            children: List.generate(
                                data.data!.examTerms!.length, (index) {
                              final examTerm = data.data!.examTerms![index];
                              return Column(
                                children: [
                                  SemesterExam(
                                    title: examTerm.title ?? '',
                                    examList: examTerm.exams ?? [],
                                    quizList: examTerm.quizzes ?? [],
                                  ),
                                  Gap(8.h),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (s, e) {
                  return Text(S.of(context).noChapterFound);
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
          bottomNavigationBar: ref.watch(isLockedLastSemesterProvider) ==
                      false &&
                  ref.watch(isReviewedProvider) == false &&
                  isAuth == true
              ? Container(
                  height: 100.h,
                  color: context.cardColor,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16).r,
                  child: Container(
                    padding: const EdgeInsets.all(16).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24).r,
                      color: AppColors.primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).youhavenreatedyet,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: context.isDarkMode
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.5),
                              builder: (context) => AlertDialog(
                                insetPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                contentPadding: const EdgeInsets.all(5),
                                content: RateTeacherDialog(
                                  teacherId: teacherId,
                                  courseId: subjectId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ).r,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFAB00),
                              borderRadius: BorderRadius.circular(24).r,
                            ),
                            child: Text(
                              S.of(context).rateNow,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }

  CommonAppbarWithBg _headerSection() {
    return CommonAppbarWithBg(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subjectName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            teacherName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class SemesterListSection extends ConsumerStatefulWidget {
  const SemesterListSection({
    super.key,
    required this.subjectId,
    required this.teacherId,
  });

  final int subjectId;
  final int teacherId;

  @override
  ConsumerState<SemesterListSection> createState() =>
      _SemesterListSectionState();
}

class _SemesterListSectionState extends ConsumerState<SemesterListSection> {
  bool isVideoPlaying = false;

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(semesterListProvider(
            subjectId: widget.subjectId, teacherId: widget.teacherId))
        .when(
      data: (data) {
        return Column(
          children: [
            isVideoPlaying
                ? _PlayerWidget(videoUrl: data?.data?.video)
                : InkWell(
                    onTap: () {
                      if (data.data?.video != null) {
                        setState(() {
                          isVideoPlaying = true;
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          // padding: const EdgeInsets.symmetric(
                          //         horizontal: 16, vertical: 16)
                          // .r,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ).r,
                          width: double.infinity,
                          height: 220.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16).r,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: data!.data!.thumbnail ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        data.data?.video == null
                            ? const SizedBox()
                            : Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(95).r,
                                  child: SvgPicture.asset(
                                    Assets.svgs.playIcon,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
            if (data?.data?.semesters == null)
              Center(
                child: Text(S.of(context).NoSemesterFound),
              )
            else
              Container(
                width: double.infinity, // Expand to full width
                color: context.cardColor, // Set background color
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13).r,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      data!.data!.semesters!.length,
                      (index) {
                        final currentId = data.data!.semesters![index].id;
                        return InkWell(
                          onTap: () {
                            if (data.data!.semesters![index].isLocked == true) {
                              // Semester is locked, show a message
                              GlobalFunction.showCustomSnackbar(
                                isSuccess: false,
                                message: S.of(context).Thissemesterislocked,
                              );
                            } else {
                              // Semester is unlocked, update the selected semester ID
                              ref
                                  .read(selectedSemesterIDProvider.notifier)
                                  .state = currentId;
                              ref
                                  .read(selectedSemesterTitleProvider.notifier)
                                  .state = data.data!.semesters![index].title;
                              ref
                                  .read(questionDetailsControllerProvider
                                      .notifier)
                                  .update((state) => state.copyWith(
                                        semester:
                                            data.data!.semesters![index].title,
                                      ));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              color: currentId ==
                                      ref.watch(selectedSemesterIDProvider)
                                  ? AppColors.primaryColor
                                  : context.chipsColor,
                              borderRadius: BorderRadius.circular(32).r,
                            ),
                            child: Row(
                              children: [
                                data.data!.semesters![index].isLocked == true
                                    ? SvgPicture.asset(Assets.svgs.lock)
                                    : const SizedBox(),
                                Gap(8.w),
                                Text(
                                  data.data!.semesters![index].title ?? '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: currentId ==
                                            ref.watch(
                                                selectedSemesterIDProvider)
                                        ? Colors.white
                                        : null,
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
        );
      },
      error: (s, e) {
        return const Text("Error");
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}

class _PlayerWidget extends ConsumerStatefulWidget {
  const _PlayerWidget({required this.videoUrl});

  final String videoUrl;

  @override
  ConsumerState<_PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<_PlayerWidget>
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("videoUrlddd: ${widget.videoUrl}");
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : const Center(child: CircularProgressIndicator()),
        ),

        // // Button to capture the screenshot
      ],
    );
  }
}
