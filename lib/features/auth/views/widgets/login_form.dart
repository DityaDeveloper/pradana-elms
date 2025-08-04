import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/auth/logic/auth_providers.dart';
import 'package:lms/features/auth/views/widgets/parent_form.dart';
import 'package:lms/features/auth/views/widgets/student_form.dart';
import 'package:lms/generated/l10n.dart';

class LoginFormSection extends ConsumerWidget {
  const LoginFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isStudentFormView = ref.watch(isStudentLoginViewProvider);
    return Expanded(
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
        child: Column(
          children: [
            //_buttonSection(context),
            Gap(24.h),
            const StudentForm() 
            //isStudentFormView ? const StudentForm() : const ParentForm(),
          ],
        ),
      ),
    );
  }

  Widget _buttonSection(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isStudentFormView = ref.watch(isStudentLoginViewProvider);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4).r,
          decoration: BoxDecoration(
            // color: const Color(0xffF6F6F6),
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    ref.read(isStudentLoginViewProvider.notifier).state = true;
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isStudentFormView ? context.containerColor : null,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      S.of(context).student,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 13.sp,
                        color:
                            isStudentFormView ? AppColors.primaryColor : null,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => ref
                      .read(isStudentLoginViewProvider.notifier)
                      .state = false,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isStudentFormView ? null : context.containerColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      S.of(context).parent,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 13.sp,
                        color:
                            isStudentFormView ? null : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
