import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/parent/logic/providers.dart';
import 'package:lms/features/parent/models/child_model.dart';
import 'package:lms/gen/assets.gen.dart';

class ChildModalBottomSheet extends ConsumerWidget {
  const ChildModalBottomSheet({
    super.key,
    required this.childList,
  });

  final List<ChildModel>? childList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6.h,
            width: 75.w,
            margin: const EdgeInsets.symmetric(vertical: 8).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 24.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    childList!.length,
                    (index) {
                      final selectedChild = ref.watch(selectedChildProvider);
                      return Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16.r),
                            child: InkWell(
                              onTap: () {
                                ref.read(selectedChildProvider.notifier).state =
                                    childList![index];
                                context.pop();
                              },
                              borderRadius: BorderRadius.circular(16.r),
                              child: Container(
                                padding: const EdgeInsets.all(16).r,
                                decoration: BoxDecoration(
                                  // color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: selectedChild == childList![index]
                                        ? AppColors.primaryColor
                                        : AppColors.borderColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 44.r,
                                      width: 44.r,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            childList![index].profilePicture ??
                                                '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(16.w),
                                    Expanded(
                                      child: Text(
                                        childList![index].name ?? '',
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    selectedChild == childList![index]
                                        ? SvgPicture.asset(
                                            Assets.svgs.checkCircle)
                                        : const Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xff6D6D6D),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Gap(16.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
