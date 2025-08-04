import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/features/dashboard/logic/providers.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../generated/l10n.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(searchSubjectProvider.notifier).searchSubject(query: '');
    });
  }

  Color getRandomColor() {
    math.Random random = math.Random();
    return Color.fromARGB(
      255, // Fully opaque
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    height: 132.h,
                    width: double.infinity,
                  ),
                  Image.asset(
                    Assets.pngs.bg.path,
                    height: 132.h,
                    // width: 132.w,
                    // width: double.infinity,
                    // height: 250.h,
                    // fit: BoxFit.cover,
                    // colorFilter:
                    //     const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  )
                ],
              ),
              // SizedBox(
              //   height: 132.h,
              //   width: double.infinity,
              //   child: SvgPicture.asset(
              //     Assets.svgs.appbarBg,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                  top: 56.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        ref.read(bottomNavigationIndexProvider.notifier).state =
                            0;
                      },
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? Matrix4.rotationY(math.pi)
                                : Matrix4.identity(),
                        child: SvgPicture.asset(
                          Assets.svgs.arrowLeft,
                          colorFilter: const ColorFilter.mode(
                            AppColors.whiteColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.r),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            ref
                                .read(searchSubjectProvider.notifier)
                                .searchSubject(query: value);
                          });
                        },
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: S.of(context).search,
                          isDense: true,
                          hintStyle: TextStyle(
                            color: AppColors.whiteColor.withOpacity(0.6),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          filled: true,
                          fillColor: AppColors.primaryColor,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: SvgPicture.asset(
                              Assets.svgs.search,
                              colorFilter: const ColorFilter.mode(
                                AppColors.whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                                color: AppColors.primaryMoreLightColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                                color: AppColors.primaryLightColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                                color: AppColors.primaryMoreLightColor),
                          ),
                        ),
                        cursorColor: AppColors.whiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ref.watch(searchSubjectProvider).when(data: (list) {
              return list.isEmpty
                  ? Center(
                      child: Text(S.of(context).searchBySub),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(16.r),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.r,
                        crossAxisSpacing: 10.r,
                        mainAxisExtent: 180.r,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // width: 120.w,
                          height: 140.h,
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.all(12).r,
                          // margin: const EdgeInsets.only(right: 12).r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: getRandomColor().withOpacity(0.2),
                            border: Border.all(
                              color: AppColors.borderColor.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              if (list[index].isLocked == false) {
                                // check is reviewed or not
                                ref.read(isReviewedProvider.notifier).state =
                                    list[index].isReviewed ?? false;
                                // navigate to subject based teacher screen
                                context.push(
                                  Routes.subjectBasedTeacher,
                                  extra: {
                                    'subjectId': list[index].id,
                                    'subjectName': list[index].title,
                                  },
                                );
                              } else {
                                context.push(
                                  Routes.singleSubscription,
                                  extra: list[index],
                                );
                              }
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 88.r,
                                      width: 88.r,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: Colors.green.withOpacity(0.1),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: list[index].thumbnail ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(8.h),
                                    Text(
                                      list[index].title ?? '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${list[index].videoCount} ${S.of(context).videos}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff5D5D5D),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -12,
                                  right: -6,
                                  child: list[index].isLocked == true
                                      ? Container(
                                          decoration: BoxDecoration(
                                            // border radius only left bottom
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(16.r),
                                            ),
                                            // color: Colors.white,
                                          ),
                                          padding: const EdgeInsets.all(8).r,
                                          child: SvgPicture.asset(
                                              Assets.svgs.lock),
                                        )
                                      : const SizedBox(),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }, error: (error, stack) {
              return Center(
                child: Text(
                  error.toString(),
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }),
          ),
          Gap(60.h),
        ],
      ),
    );
  }
}
