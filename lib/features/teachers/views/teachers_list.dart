import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/home/views/widgets/techers_section.dart';
import 'package:lms/features/teachers/logic/teacher_controller.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../generated/l10n.dart';

class TeachersList extends ConsumerStatefulWidget {
  const TeachersList({super.key});

  @override
  ConsumerState<TeachersList> createState() => _TeachersListState();
}

class _TeachersListState extends ConsumerState<TeachersList> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounce;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(teacherListProvider.notifier).searchTeacher(query: '');
    });
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref.read(teacherListProvider.notifier).loadMore();
      print('load more');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(context),
          ref.watch(teacherListProvider).when(
                data: (data) {
                  return Expanded(
                    child: data.isEmpty
                        ? Center(
                            child: Text(S.of(context).noDataFound),
                          )
                        : GridView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.all(16.r),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.r,
                              crossAxisSpacing: 10.r,
                              mainAxisExtent: 200.r,
                            ),
                            itemCount: data.length +
                                (ref
                                        .watch(teacherListProvider.notifier)
                                        .isLastPage
                                    ? 0
                                    : 1),
                            itemBuilder: (context, index) {
                              if (index == data.length) {
                                // // Show loading indicator or "no more data"
                                // return ref
                                //         .watch(subjectListProvider.notifier)
                                //         .isLastPage
                                //     ? const Center(child: Text("No more data"))
                                //     : const Center(
                                //         child: CircularProgressIndicator());
                                return const SizedBox();
                              }
                              return InkWell(
                                onTap: () {
                                  context.push(
                                    Routes.teachers,
                                    extra: {
                                      'teacherId': data[index].id,
                                      'isParentView': false,
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6).r,
                                  clipBehavior: Clip.antiAlias,
                                  // margin: const EdgeInsets.only(right: 12).r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 125.r,
                                            width: 142.w,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            // child: Image.asset(
                                            //   "assets/pngs/image.png",
                                            //   fit: BoxFit.cover,
                                            // ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  data[index].profilePicture ??
                                                      '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Stack(
                                              children: [
                                                CustomPaint(
                                                  size: Size(55.w, 25.h),
                                                  painter: RPSCustomPainter(
                                                    color: context.isDarkMode
                                                        ? AppColors
                                                            .darkPrimaryColor
                                                        : Colors.white,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Gap(Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            'ar'
                                                        ? 12.w
                                                        : 0.w),
                                                    Assets.pngs.star.image(
                                                        width: 14.r,
                                                        height: 14.r),
                                                    Gap(2.w),
                                                    Text(
                                                      data[index]
                                                          .averageRating
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Gap(8.h),
                                      Text(
                                        data[index].name ?? '',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Gap(6.h),
                                      Text(
                                        data[index].title ?? '',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff5D5D5D),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      stackTrace.toString(),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20.sp,
                      ),
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        ],
      ),
    );
  }

  CommonAppbarWithBg _headerSection(BuildContext context) {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Expanded(
            child: _isSearching
                ? TextField(
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        ref
                            .read(teacherListProvider.notifier)
                            .searchTeacher(query: value);
                      });
                    },
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: S.of(context).search,
                      isDense: true,
                      hintStyle: TextStyle(
                        color: AppColors.primaryLightColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: AppColors.primaryColor,
                      // suffixIcon: Padding(
                      //   padding: EdgeInsets.all(10.r),
                      //   child: SvgPicture.asset(
                      //     Assets.svgs.search,
                      //     colorFilter: const ColorFilter.mode(
                      //       AppColors.whiteColor,
                      //       BlendMode.srcIn,
                      //     ),
                      //   ),
                      // ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.primaryLightColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.primaryLightColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.primaryLightColor),
                      ),
                    ),
                    cursorColor: AppColors.whiteColor,
                  )
                : Text(
                    S.of(context).allTeachers,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: () {
              setState(() {
                _isSearching = !_isSearching;
                if (_isSearching) {
                  _searchFocusNode.requestFocus();
                } else {
                  _searchFocusNode.unfocus();
                  _searchController.clear();
                  ref
                      .read(teacherListProvider.notifier)
                      .searchTeacher(query: '');
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xff007AC9),
              ),
              child: _isSearching
                  ? const Icon(
                      Icons.close,
                      color: Colors.white,
                    )
                  : SvgPicture.asset(
                      Assets.svgs.search,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
