import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:lms/features/auth/views/widgets/privacy_policy_terms_condition.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class SignUpFormSection extends ConsumerStatefulWidget {
  const SignUpFormSection({
    super.key,
    required this.isDataFilled,
    this.hasSocialData,
  });

  final bool isDataFilled;
  final Map<String, dynamic>? hasSocialData;

  @override
  ConsumerState<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends ConsumerState<SignUpFormSection> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: Hive.box(AppConstants.authBox).listenable(),
              builder: (context, Box box, child) {
                return FormBuilder(
                  key: _formKey,
                  initialValue: widget.isDataFilled == true
                      ? {
                          "name": box.get(AppConstants.userData,
                              defaultValue: null)?['name'],
                          "email": box.get(AppConstants.userData,
                              defaultValue: null)?['email'],
                          "phone": box.get(AppConstants.userData,
                              defaultValue: null)?['phone'],
                          "parent_phone": box.get(AppConstants.userData,
                              defaultValue: null)?['parent_phone'],
                        }
                      : {
                          "name": "",
                          "email": "",
                          "phone": "",
                          "parent_phone": "",
                        },
                  child: Column(
                    children: [
                      Gap(5.h),
                      FormBuilderTextField(
                        name: "name",
                        readOnly: widget.hasSocialData != null &&
                                box.get(AppConstants.userData,
                                        defaultValue: null)?['name'] !=
                                    null
                            ? true
                            : false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          fillColor: widget.hasSocialData != null &&
                                  box.get(AppConstants.userData,
                                          defaultValue: null)?['name'] !=
                                      null
                              ? Colors.grey.withOpacity(0.1)
                              : null,
                          filled: widget.hasSocialData != null &&
                                  box.get(AppConstants.userData,
                                          defaultValue: null)?['name'] !=
                                      null
                              ? true
                              : false,
                          label: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(S.of(context).fullName),
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
                      Gap(24.h),
                      FormBuilderTextField(
                        name: "email",
                        readOnly: widget.hasSocialData != null &&
                                box.get(AppConstants.userData,
                                        defaultValue: null)?['email'] !=
                                    null
                            ? true
                            : false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: widget.hasSocialData != null &&
                                  box.get(AppConstants.userData,
                                          defaultValue: null)?['email'] !=
                                      null
                              ? Colors.grey.withOpacity(0.1)
                              : null,
                          filled: widget.hasSocialData != null &&
                                  box.get(AppConstants.userData,
                                          defaultValue: null)?['email'] !=
                                      null
                              ? true
                              : false,
                          label: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(S.of(context).email),
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
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      Gap(24.h),
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
                      Gap(24.h),
                      FormBuilderTextField(
                        name: "parent_phone",
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          label: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(S.of(context).parentPhone),
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
                      Visibility(
                        visible: widget.hasSocialData == null,
                        child: Column(
                          children: [
                            Gap(24.h),
                            FormBuilderTextField(
                              name: "password",
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                label: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(S.of(context).password),
                                    Gap(6.w),
                                    SvgPicture.asset(
                                      Assets.svgs.star,
                                      height: 8.r,
                                    )
                                  ],
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8),
                              ]),
                            ),
                            Gap(24.h),
                            FormBuilderTextField(
                              name: "password_confirmation",
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                label: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(S.of(context).confirmPassword),
                                    Gap(6.w),
                                    SvgPicture.asset(
                                      Assets.svgs.star,
                                      height: 8.r,
                                    )
                                  ],
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8),
                                (val) {
                                  // Compare to the 'password' field in the form
                                  final passwordVal = _formKey
                                      .currentState?.fields['password']?.value;
                                  if (val != passwordVal) {
                                    return S.of(context).passwordDoNotMatch;
                                  }
                                  return null;
                                },
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Gap(24.h),
                      FormBuilderCheckbox(
                        name: 'checkbox',
                        title: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              "${S.of(context).iAcceptAndAgree} ",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: 16.h, vertical: 24.h),
                                      child: PrivacyPolicyTermsCondition(
                                        title: S.of(context).termsAndConditions,
                                        isPrivacyPolicy: false,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                S.of(context).termsAndConditions,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              " ${S.of(context).and} ",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: 16.h, vertical: 24.h),
                                      child: PrivacyPolicyTermsCondition(
                                        title: S.of(context).privacyPolicy,
                                        isPrivacyPolicy: true,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                S.of(context).privacyPolicy,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              " ${S.of(context).ofBridge}",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        initialValue: false,
                        onChanged: (value) {},
                        activeColor: AppColors.primaryColor,
                        contentPadding: const EdgeInsets.all(0),
                        visualDensity: const VisualDensity(horizontal: -4),
                        controlAffinity: ListTileControlAffinity.leading,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Gap(25.h),
                      Consumer(
                        builder: (context, ref, child) {
                          final loading = ref.watch(registrationProvider);
                          final socialLoading = ref.watch(socialLoginProvider);
                          return loading || socialLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomButton(
                                  title: widget.hasSocialData != null
                                      ? S.of(context).complete_profile
                                      : S.of(context).signUp,
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: AppColors.whiteColor,
                                  onPressed: () {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      if (_formKey.currentState!
                                              .value['checkbox'] ==
                                          true) {
                                        Map<String, dynamic> data =
                                            _formKey.currentState!.value;

                                        if (widget.hasSocialData != null) {
                                          final socialData = {
                                            ...data,
                                            ...widget.hasSocialData!
                                          };
                                          ref
                                              .read(
                                                  socialLoginProvider.notifier)
                                              .socialLogin(data: socialData)
                                              .then((value) {
                                            if (value != null) {
                                              context
                                                  .go(Routes.otpScreen, extra: {
                                                'isParentLogin': false,
                                                'otpCode':
                                                    value.data?.otpCode ?? "",
                                                'phoneNumber': data['phone'],
                                              });
                                            }
                                          });
                                        } else {
                                          ref
                                              .read(
                                                  registrationProvider.notifier)
                                              .registration(
                                                data: data,
                                              )
                                              .then((value) {
                                            if (value != null) {
                                              context
                                                  .go(Routes.otpScreen, extra: {
                                                'isParentLogin': false,
                                                'otpCode':
                                                    value.data?.otpCode ?? "",
                                                'phoneNumber': data['phone'],
                                              });
                                            }
                                          });
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  AppColors.errorColor,
                                              content: Text(
                                                S.of(context).pleaseAccept,
                                              ),
                                            ),
                                          );
                                      }
                                    }
                                  },
                                );
                        },
                      ),
                      Gap(15.h),
                      // already have an account
                      Visibility(
                        visible: widget.hasSocialData == null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).alreadyHaveAnAccount,
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            Gap(8.w),
                            InkWell(
                              onTap: () {
                                context.go(Routes.login);
                              },
                              child: Text(
                                S.of(context).login,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
