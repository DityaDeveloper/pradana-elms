import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/custom_button.dart';

import '../../../../generated/l10n.dart';

class ExamExitConfirmationDialog extends StatelessWidget {
  final String description;
  final VoidCallback onExit;

  const ExamExitConfirmationDialog({
    super.key,
    required this.description,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h)
            .copyWith(top: 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: Color(0x19FF5630),
              radius: 30,
              child: Icon(
                Icons.close,
                color: Color(0xFFFF5630),
              ),
            ),
            Gap(16.h),
            Text(
              S.of(context).areyouSure,
              style: context.textTheme.titleMedium?.copyWith(
                color: const Color(0xFFFF5630),
              ),
            ),
            Gap(12.h),
            Text(
              "${S.of(context).wanttoexitfrom} '$description",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomButton(
                    title: S.of(context).yes,
                    backgroundColor: const Color(0xFFE7E7E7),
                    foregroundColor: Colors.black,
                    onPressed: onExit,
                  ),
                ),
                Gap(12.w),
                Flexible(
                  flex: 1,
                  child: CustomButton(
                    title: S.of(context).No,
                    backgroundColor: const Color(0xFFFF5630),
                    foregroundColor: AppColors.whiteColor,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
