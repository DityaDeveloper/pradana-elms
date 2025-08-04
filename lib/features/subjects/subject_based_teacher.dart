import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/message/logic/providers.dart';

import '../../generated/l10n.dart';

class SubjectBasedTeacher extends ConsumerWidget {
  const SubjectBasedTeacher(
      {super.key, required this.subjectId, required this.subjectName});

  final int subjectId;
  final String subjectName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(context),
          ref.watch(subjectBasedTeacherProvider(subjectId)).when(
                data: (data) {
                  return Expanded(
                    child: data == null || data.isEmpty
                        ? Center(
                            child: Text(
                              S.of(context).noDataFound,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16).r,
                            itemCount: data.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                ref
                                    .read(questionDetailsControllerProvider
                                        .notifier)
                                    .update(
                                      (state) => state.copyWith(
                                        subject: subjectName,
                                      ),
                                    );
                                context.push(Routes.semester, extra: {
                                  'subjectName': subjectName,
                                  'teacherName': data[index].name,
                                  'subjectId': subjectId,
                                  'teacherId': data[index].id,
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12).r,
                                margin: const EdgeInsets.only(bottom: 10).r,
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(10).r,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 85.h,
                                      width: 85.w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12).r,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            data[index].profilePicture ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].name ?? '',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Gap(4.w),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  margin: const EdgeInsets.only(
                                                          right: 5)
                                                      .r,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF0F8FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                100)
                                                            .r,
                                                  ),
                                                  child: Text(
                                                    "${data[index].videoCount} ${S.of(context).videos}",
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  margin: const EdgeInsets.only(
                                                          right: 5)
                                                      .r,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF0F8FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                100)
                                                            .r,
                                                  ),
                                                  child: Text(
                                                    "${data[index].examCount} ${S.of(context).exam}",
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  margin: const EdgeInsets.only(
                                                          right: 5)
                                                      .r,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF0F8FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                                100)
                                                            .r,
                                                  ),
                                                  child: Text(
                                                    "${data[index].noteCount} ${S.of(context).notes}",
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(4.w),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: List.generate(5,
                                                        (starIndex) {
                                                      final double rating = (data[
                                                                      index]
                                                                  .averageRating ??
                                                              0.0)
                                                          .toDouble(); // Get the rating value
                                                      if (starIndex <
                                                          rating.floor()) {
                                                        // Full star
                                                        return Icon(
                                                          Icons.star,
                                                          color: const Color(
                                                              0xffFFAB00),
                                                          size: 16.r,
                                                        );
                                                      } else if (starIndex <
                                                              rating &&
                                                          starIndex <
                                                              rating.ceil()) {
                                                        // Half star
                                                        return Icon(
                                                          Icons.star_half,
                                                          color: const Color(
                                                              0xffFFAB00),
                                                          size: 16.r,
                                                        );
                                                      } else {
                                                        // Empty star
                                                        return const SizedBox();
                                                      }
                                                    }),
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    data[index]
                                                        .averageRating
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 14.r,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  );
                },
                error: (e, s) {
                  return Center(
                    child: Text("Error: $e"),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              )
        ],
      ),
    );
  }

  Widget _headerSection(context) {
    return CommonAppbarWithBg(
      child: Text(
        subjectName,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
