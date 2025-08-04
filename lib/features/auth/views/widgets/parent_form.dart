import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class ParentForm extends ConsumerStatefulWidget {
  const ParentForm({
    super.key,
  });

  @override
  ConsumerState<ParentForm> createState() => _ParentFormState();
}

class _ParentFormState extends ConsumerState<ParentForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FormBuilder(
        key: _formKey,
        initialValue: const {
          "phone": "01600000000",
          "password": "secret@123",
        },
        child: Column(
          children: [
            FormBuilderTextField(
              name: "phone",
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                label: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.of(context).phone),
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
                FormBuilderValidators.numeric(),
              ]),
            ),
            Gap(48.h),
            Consumer(
              builder: (context, ref, child) {
                final sendOTPLoading = ref.watch(sendOTPProvider);
                return sendOTPLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        title: S.of(context).proceedNext,
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            ref
                                .read(sendOTPProvider.notifier)
                                .sendOTP(
                                    phone: _formKey
                                        .currentState!.fields['phone']!.value
                                        .toString())
                                .then((value) {
                              if (value != null) {
                                context.go(Routes.otpScreen, extra: {
                                  'isParentLogin': true,
                                  'otpCode': value,
                                  'phoneNumber': _formKey
                                      .currentState!.fields['phone']!.value
                                      .toString(),
                                });
                              }
                            });
                          }
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
