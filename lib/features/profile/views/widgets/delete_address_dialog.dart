import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class DeleteAddressDialog extends ConsumerWidget {
  const DeleteAddressDialog({super.key, required this.addressId});

  final int addressId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteLoading = ref.watch(deleteAddressProvider);
    return Stack(
      // mainAxisSize: MainAxisSize.min,
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(50.h),
            Text(
              S.of(context).areYouSureDeleteAddress,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: context.isDarkMode ? Colors.white : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(25.h),
            Row(
              children: [
                Expanded(
                  child: deleteLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          onPressed: () {
                            ref
                                .read(deleteAddressProvider.notifier)
                                .deleteAddress(addressId)
                                .then((val) {
                              Navigator.pop(context);
                              if (val == true) {
                                ref.invalidate(addressListProvider);
                                GlobalFunction.showCustomSnackbar(
                                    message: S.of(context).deleteSuccessfully,
                                    isSuccess: true);
                                Navigator.pop(context);
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xffF6F6F6),
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            // border color
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: AppColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(54).r,
                            ),
                          ),
                          child: Text(
                            S.of(context).yes,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
                Gap(16.w),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                    ),
                    child: Text(
                      S.of(context).No,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Gap(10.h),
          ],
        ),
        Positioned(
          top: -35.h,
          child: Container(
            padding: const EdgeInsets.all(20).r,
            margin: const EdgeInsets.only(right: 14).r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              // box shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: SvgPicture.asset(Assets.svgs.trash, color: Colors.red),
          ),
        )
      ],
    );
  }
}
