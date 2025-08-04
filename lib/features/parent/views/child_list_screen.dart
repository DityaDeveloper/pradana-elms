import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/features/parent/logic/parent_controller.dart';
import 'package:lms/features/parent/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../generated/l10n.dart';

class ChildListScreen extends ConsumerWidget {
  const ChildListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BG(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _logoSection(),
          Gap(32.h),
          _textInfo(context),
          Gap(20.h),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.containerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: ref.watch(childListProvider).when(
                  data: (list) {
                    return list == null
                        ? const Center(
                            child: Text("No Children Found"),
                          )
                        : Column(
                            children: List.generate(
                              list.length,
                              (index) {
                                return Column(
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: InkWell(
                                        onTap: () {
                                          context.go(
                                            Routes.parentViewProgress,
                                            extra: list,
                                          );
                                          ref
                                              .read(selectedChildProvider
                                                  .notifier)
                                              .state = list[index];
                                        },
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        child: Container(
                                          padding: const EdgeInsets.all(16).r,
                                          decoration: BoxDecoration(
                                            // color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 0.5,
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
                                                  imageUrl: list[index]
                                                          .profilePicture ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Gap(16.w),
                                              Expanded(
                                                child: Text(
                                                  list[index].name ?? '',
                                                  style: context
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                              const Icon(
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
                          );
                  },
                  error: (error, stack) {
                    return Center(
                      child: Text(
                        error.toString(),
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _logoSection() {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: SvgPicture.asset(
        Assets.svgs.logoDark,
        colorFilter: const ColorFilter.mode(
          AppColors.whiteColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Padding _textInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).selectProfile,
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          Gap(12.sp),
          Text(
            S.of(context).selectyourchildprofiletoviewtheiracademicprogress,
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
