import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/home/logic/system_setting_controller.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../../generated/l10n.dart';

class EmergencySupportScreen extends ConsumerStatefulWidget {
  const EmergencySupportScreen({super.key});

  @override
  ConsumerState<EmergencySupportScreen> createState() =>
      _EmergencySupportScreenState();
}

class _EmergencySupportScreenState
    extends ConsumerState<EmergencySupportScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> purposeList = ["Purpose 1", "Purpose 2", "Purpose 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
      body: Column(
        children: [
          _headerSection(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Gap(25.h),
                      ClipOval(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Container(
                              height: 150.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.2)),
                            ),
                            SvgPicture.asset(
                              Assets.svgs.customerSupport,
                            )
                          ],
                        ),
                      ),

                      Gap(20.h),
                      Text(
                        S.of(context).needHelp,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              context.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Gap(10.h),
                      Text(
                        S.of(context).contactOurSupportTeamToday,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:
                              context.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Gap(24.h),
                      FormBuilderDropdown(
                        name: "subject",
                        items: purposeList.map((purpose) {
                          return DropdownMenuItem(
                            value: purpose,
                            child: Text(
                              purpose,
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }).toList(),
                        icon: SvgPicture.asset(
                          Assets.svgs.arrowDown,
                          height: 20.r,
                        ),
                        decoration: InputDecoration(
                          label: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(S.of(context).purpose),
                              Gap(6.w),
                              SvgPicture.asset(
                                Assets.svgs.star,
                                height: 8.r,
                              )
                            ],
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(20.h),
                      // write message
                      FormBuilderTextField(
                        name: "description",
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: S.of(context).writeyourmessagehere,
                          hintStyle: context.textTheme.bodyLarge!.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      Gap(20.h),
                      Consumer(
                        builder: (context, ref, child) {
                          final loading = ref.watch(supportProvider);
                          return loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomButton(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  title: S.of(context).send,
                                  onPressed: () {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      ref
                                          .read(supportProvider.notifier)
                                          .support(
                                            data: _formKey.currentState!.value,
                                          )
                                          .then((value) {
                                        if (value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                S
                                                    .of(context)
                                                    .yourmessagehasbeensentsuccessfully,
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          _formKey.currentState!.reset();
                                        }
                                      });
                                    }
                                  },
                                );
                        },
                      ),
                      Gap(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).orcontactusat),
                          Gap(4.w),
                          Text(
                            ref
                                    .watch(systemSettingProvider.notifier)
                                    .supportNumber ??
                                "+8801725115085",
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _headerSection() {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).emergencySupport,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
