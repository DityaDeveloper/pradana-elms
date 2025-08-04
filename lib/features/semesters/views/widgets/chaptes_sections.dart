import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/semesters/models/chapter_model/lesson.dart';
import 'package:lms/features/semesters/models/chapter_model/resource.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class ChaptersSection extends ConsumerStatefulWidget {
  const ChaptersSection({
    super.key,
    required this.title,
    required this.lessonList,
    required this.resources,
    required this.teacherId,
    required this.chapterId,
    required this.subjectId,
  });

  final String title;
  final List<Lesson> lessonList;
  final List<Resource> resources;
  final int teacherId;
  final int chapterId;
  final int subjectId;

  @override
  ConsumerState<ChaptersSection> createState() => _ChaptersSectionState();
}

class _ChaptersSectionState extends ConsumerState<ChaptersSection> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.svgs.bookSaved,
              colorFilter: ColorFilter.mode(
                _isExpanded ? AppColors.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            Gap(8.w),
            Expanded(
                child: Text(widget.title, style: context.textTheme.bodyLarge)),
          ],
        ),
        trailing: Transform.rotate(
          angle: _isExpanded ? 3.14 : 0,
          child: SvgPicture.asset(
            Assets.svgs.arrowDown,
            color: _isExpanded ? AppColors.primaryColor : Colors.grey,
          ),
        ),
        backgroundColor: _isExpanded
            ? Color(context.isDarkMode ? 0xff3D3D3D : 0xffF0F8FF)
            : Colors.white,
        collapsedBackgroundColor: context.cardColor,
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          IntrinsicHeight(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 2.w,
                    color: const Color(0xffB9E2FE),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12).r,
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.circular(10).r,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: widget.lessonList.isEmpty
                              ? Center(
                                  child: Text(S.of(context).noChapterFound))
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    widget.lessonList.length,
                                    (index) => InkWell(
                                      onTap: () {
                                        if (widget.lessonList[index].isLocked ==
                                            true) {
                                          GlobalFunction.showCustomSnackbar(
                                            message: 'This lesson is locked',
                                            isSuccess: false,
                                          );
                                        } else {
                                          ref
                                              .read(
                                                  questionDetailsControllerProvider
                                                      .notifier)
                                              .update(
                                                (state) => state.copyWith(
                                                    lesson: widget
                                                        .lessonList[index]
                                                        .title,
                                                    chapter: widget.title),
                                              );

                                          context.push(
                                            Routes.lessonVideoPlayer,
                                            extra: {
                                              'semester_title': ref.read(
                                                  selectedSemesterTitleProvider),
                                              'chapter_title': widget.title,
                                              'lessonList': widget.lessonList,
                                              'chapterId': widget.chapterId,
                                              'teacherId': widget.teacherId,
                                              'subjectId': widget.subjectId,
                                              'selectedPassLesson':
                                                  widget.lessonList[index],
                                            },
                                          );
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              widget.lessonList[index]
                                                          .isLocked ==
                                                      true
                                                  ? Container(
                                                      margin: Localizations
                                                                      .localeOf(
                                                                          context)
                                                                  .languageCode ==
                                                              'ar'
                                                          ? const EdgeInsets
                                                              .only(left: 10)
                                                          : const EdgeInsets
                                                                  .only(
                                                                  right: 10)
                                                              .r,
                                                      child: SvgPicture.asset(
                                                          Assets.svgs.lock),
                                                    )
                                                  : const SizedBox(),
                                              Container(
                                                height: 36.r,
                                                width: 36.r,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(6)
                                                          .r,
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: widget
                                                          .lessonList[index]
                                                          .thumbnailLink ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Gap(8.w),
                                              Expanded(
                                                child: Text(
                                                  widget.lessonList[index]
                                                          .title ??
                                                      '',
                                                  style: context
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Gap(6.w),
                                              SizedBox(
                                                height: 18.r,
                                                width: 18.r,
                                                child: Transform(
                                                  alignment: Alignment.center,
                                                  transform: Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          'ar'
                                                      ? Matrix4.rotationY(
                                                          math.pi)
                                                      : Matrix4.identity(),
                                                  child: SvgPicture.asset(
                                                    Assets
                                                        .svgs.arrowRightCircle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          index == widget.lessonList.length - 1
                                              ? const SizedBox()
                                              : Divider(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Gap(8.h),
                        widget.resources.isEmpty
                            ? const Center(
                                child: Text(""),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8).r,
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(10).r,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      widget.resources.length,
                                      (int index) {
                                        return InkWell(
                                          onTap: () {
                                            if (widget
                                                .resources[index].isLocked!) {
                                              GlobalFunction.showCustomSnackbar(
                                                message:
                                                    'This resource is locked',
                                                isSuccess: false,
                                              );
                                            } else {
                                              context.push(
                                                "${Routes.semester}${Routes.pdfView}",
                                                extra: widget.resources[index]
                                                        .media ??
                                                    '',
                                              );
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 105.w,
                                                padding:
                                                    const EdgeInsets.all(10).r,
                                                margin:
                                                    EdgeInsets.only(right: 8.w),
                                                decoration: BoxDecoration(
                                                  color: context.cardColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10)
                                                          .r,
                                                  border: Border.all(
                                                    color:
                                                        AppColors.borderColor,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 36.h,
                                                      width: 36.w,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF6F6F6),
                                                        borderRadius:
                                                            BorderRadius
                                                                    .circular(8)
                                                                .r,
                                                      ),
                                                      child: Assets.pngs.pdfDemo
                                                          .image(),
                                                    ),
                                                    Gap(8.h),
                                                    Text(
                                                      widget.resources[index]
                                                              .title ??
                                                          '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (widget
                                                  .resources[index].isLocked!)
                                                Positioned(
                                                  right: 16,
                                                  top: 10,
                                                  child: Container(
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        Assets.svgs.lock,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
