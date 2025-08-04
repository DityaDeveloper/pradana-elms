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
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../generated/l10n.dart';

class SubjectsList extends ConsumerStatefulWidget {
  const SubjectsList({super.key});

  @override
  ConsumerState<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends ConsumerState<SubjectsList> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounce;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(subjectListProvider.notifier).searchSubject(query: '');
    });
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref.read(subjectListProvider.notifier).loadMore();
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
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(context),
          ref.watch(subjectListProvider).when(
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
                              mainAxisExtent: 175.r,
                            ),
                            itemCount: data.length +
                                (ref
                                        .watch(subjectListProvider.notifier)
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
                                  if (data[index].isLocked == false) {
                                    // check is reviewed or not
                                    ref
                                            .read(isReviewedProvider.notifier)
                                            .state =
                                        data[index].isReviewed ?? false;
                                    // navigate to subject based teacher screen
                                    context.push(
                                      Routes.subjectBasedTeacher,
                                      extra: {
                                        'subjectId': data[index].id,
                                        'subjectName': data[index].title,
                                      },
                                    );
                                  } else {
                                    context.push(
                                      Routes.singleSubscription,
                                      extra: data[index],
                                    );
                                  }
                                },
                                borderRadius: BorderRadius.circular(12.r),
                                child: Container(
                                  // width: 120.w,
                                  height: 140.h,
                                  clipBehavior: Clip.antiAlias,
                                  padding: const EdgeInsets.all(12).r,
                                  // margin: const EdgeInsets.only(right: 12).r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.green.withOpacity(0.1),
                                    border: Border.all(
                                      color: AppColors.borderColor
                                          .withOpacity(0.2),
                                      width: 2,
                                    ),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 88.r,
                                            width: 88.r,
                                            // child: Image.asset(
                                            //   "assets/pngs/book1.png",
                                            //   fit: BoxFit.cover,
                                            // ),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              color:
                                                  Colors.green.withOpacity(0.1),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  data[index].thumbnail ?? '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Gap(8.h),
                                          Text(
                                            data[index].title ?? '',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${data[index].videoCount} ${S.of(context).videos}",
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
                                        child: data[index].isLocked == true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  // border radius only left bottom
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(16.r),
                                                  ),
                                                  // color: Colors.white,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8).r,
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
                          ),
                  );
                },
                error: (error, stack) {
                  return Center(
                    child: Text("Error: $error"),
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
                            .read(subjectListProvider.notifier)
                            .searchSubject(query: value);
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
                    S.of(context).allSubjects,
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
                      .read(subjectListProvider.notifier)
                      .searchSubject(query: '');
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.primaryLightColor,
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
