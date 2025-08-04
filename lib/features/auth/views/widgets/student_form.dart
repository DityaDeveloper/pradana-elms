import 'dart:io';

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
import 'package:lms/features/auth/data/social_auth.dart';
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class StudentForm extends ConsumerStatefulWidget {
  const StudentForm({
    super.key,
  });

  @override
  ConsumerState<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends ConsumerState<StudentForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;
  final int _count = 0;
  bool _facebookLoading = false;
  bool _googleLoading = false;
  bool _appleLoading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          initialValue: const {
            "phone": "081292921433",
            "password": "secret@123",
          },
          child: Column(
            children: [
              Gap(6.h),
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
                name: "password",
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
              Consumer(
                builder: (context, ref, child) {
                  final loading = ref.watch(loginProvider);
                  return loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          title: S.of(context).login,
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.whiteColor,
                          onPressed: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              await ref
                                  .read(loginProvider.notifier)
                                  .login(
                                    phone: _formKey
                                        .currentState!.fields['phone']!.value,
                                    password: _formKey.currentState!
                                        .fields['password']!.value,
                                    userType: 'student',
                                  )
                                  .then((value) {
                                if (value != null) {
                                  if (value.data?.user?.otpVerified == 0) {
                                    ref
                                        .read(sendOTPProvider.notifier)
                                        .sendOTP(
                                            phone: _formKey.currentState!
                                                .fields['phone']!.value
                                                .toString())
                                        .then((value) {
                                      if (value != null) {
                                        context.go(Routes.otpScreen, extra: {
                                          'isParentLogin': false,
                                          'otpCode': value,
                                          'phoneNumber': _formKey.currentState!
                                              .fields['phone']!.value
                                              .toString(),
                                        });
                                      }
                                    });
                                  } else if (value.data?.user?.academicInfo ==
                                          null ||
                                      value.data?.user?.subscription == null) {
                                    context.go(Routes.academicInfo);
                                  } else {
                                    context.go(Routes.dashboard);
                                  }
                                } else {
                                  ref.invalidate(loginProvider);
                                }
                              });
                            }
                          },
                        );
                },
              ),
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64.w,
                    height: 1.h,
                    color: AppColors.borderColor,
                  ),
                  Gap(8.w),
                  Text(
                    S.of(context).orloginwith,
                    style: context.textTheme.bodyMedium!.copyWith(),
                  ),
                  Gap(8.w),
                  Container(
                    width: 64.w,
                    height: 1.h,
                    color: AppColors.borderColor,
                  ),
                ],
              ),
              Gap(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      // if (_count == 2) {
                      //   _formKey.currentState!.patchValue({
                      //     "phone": "01711103666",
                      //     "password": "secret123",
                      //   });
                      // }
                      // setState(() {
                      //   _count++;
                      // });

                      setState(() => _facebookLoading = true);

                      await SocialAuth.loginWithFacebook().then((res) async {
                        final userData = res.$1;
                        final accessToken = res.$2;

                        if (userData != null && accessToken != null) {
                          await ref
                              .read(checkUserProvider.notifier)
                              .checkUser(email: userData['email'])
                              .then((isUserExist) {
                            if (!isUserExist) {
                              Hive.box(AppConstants.authBox)
                                  .put(AppConstants.userData, {
                                'email': userData['email'],
                                'name': userData['name'],
                              }).then((value) {
                                context.go(Routes.signup, extra: {
                                  'isDataFilled': true,
                                  'hasSocialData': {
                                    'provider': 'facebook',
                                    'social_id': userData['id'],
                                    'access_token': accessToken,
                                  }
                                });
                              });
                            } else {
                              final sData = {
                                'email': userData['email'],
                                'provider': 'facebook',
                                'social_id': userData['id'],
                                'access_token': accessToken,
                              };
                              ref
                                  .read(socialLoginProvider.notifier)
                                  .socialLogin(data: sData)
                                  .then((value) {
                                if (value != null) {
                                  if (value.data?.user?.academicInfo == null ||
                                      value.data?.user?.subscription == null) {
                                    context.go(Routes.academicInfo);
                                  } else {
                                    context.go(Routes.dashboard);
                                  }
                                } else {
                                  ref.invalidate(loginProvider);
                                }
                              });
                            }
                          });
                        }
                      }).catchError((error) {
                        // Handle error if needed
                      }).whenComplete(() {
                        setState(() => _facebookLoading = false);
                      });
                      return;
                    },
                    child: _facebookLoading
                        ? const CircularProgressIndicator()
                        : Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: SvgPicture.asset(Assets.svgs.facebook),
                            )),
                  ),
                  Gap(32.w),
                  InkWell(
                    onTap: () async {
                      setState(() => _googleLoading = true);
                      await SocialAuth.loginWithGoogle().then((res) async {
                        final userCredential = res.userCredential;
                        final accessToken = res.accessToken;
                        print("name: ${userCredential?.user?.displayName}");
                        print("email: ${userCredential?.user?.email}");
                        print("social id: ${userCredential?.user?.uid}");
                        print("access token: $accessToken");

                        if (userCredential != null && accessToken != null) {
                          await ref
                              .read(checkUserProvider.notifier)
                              .checkUser(email: userCredential.user!.email!)
                              .then((isUserExist) {
                            if (!isUserExist) {
                              Hive.box(AppConstants.authBox)
                                  .put(AppConstants.userData, {
                                'email': userCredential.user!.email!,
                                'name': userCredential.user!.displayName,
                              }).then((value) {
                                context.go(Routes.signup, extra: {
                                  'isDataFilled': true,
                                  'hasSocialData': {
                                    'provider': 'google',
                                    'social_id': userCredential.user!.uid,
                                    'access_token': accessToken,
                                  }
                                });
                              });
                            } else {
                              final sData = {
                                'email': userCredential.user!.email!,
                                'provider': 'google',
                                'social_id': userCredential.user!.uid,
                                'access_token': accessToken,
                              };
                              ref
                                  .read(socialLoginProvider.notifier)
                                  .socialLogin(data: sData)
                                  .then((value) {
                                if (value != null) {
                                  if (value.data?.user?.academicInfo == null ||
                                      value.data?.user?.subscription == null) {
                                    context.go(Routes.academicInfo);
                                  } else {
                                    context.go(Routes.dashboard);
                                  }
                                } else {
                                  ref.invalidate(loginProvider);
                                }
                              });
                            }
                          });
                        }
                      }).catchError((error) {
                        // Handle error if needed
                      }).whenComplete(() {
                        setState(() => _googleLoading = false);
                      });

                      return;

                      // logout
                      // SocialAuth.logoutWithGoogle(
                      //     socialAuthType: SocialAuthType.google);
                    },
                    child: _googleLoading
                        ? const CircularProgressIndicator()
                        : Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0.r),
                              child: SvgPicture.asset(Assets.svgs.google),
                            )),
                  ),
                  Platform.isIOS
                      ? Row(
                          children: [
                            Gap(32.w),
                            InkWell(
                              onTap: () async {
                                setState(() => _appleLoading = true);
                                await SocialAuth.loginWithApple()
                                    .then((res) async {
                                  final userCredential = res.$1;
                                  final accessToken = res.$2;

                                  if (userCredential != null &&
                                      accessToken != null) {
                                    await ref
                                        .read(checkUserProvider.notifier)
                                        .checkUser(
                                            email: userCredential.user!.email!)
                                        .then((isUserExist) {
                                      if (!isUserExist) {
                                        Hive.box(AppConstants.authBox)
                                            .put(AppConstants.userData, {
                                          'email': userCredential.user!.email!,
                                          'name':
                                              userCredential.user!.displayName,
                                        }).then((value) {
                                          context.go(Routes.signup, extra: {
                                            'isDataFilled': true,
                                            'hasSocialData': {
                                              'provider': 'apple',
                                              'social_id':
                                                  userCredential.user!.uid,
                                              'access_token': accessToken,
                                            }
                                          });
                                        });
                                      } else {
                                        final sData = {
                                          'email': userCredential.user!.email!,
                                          'provider': 'apple',
                                          'social_id': userCredential.user!.uid,
                                          'access_token': accessToken,
                                        };
                                        ref
                                            .read(socialLoginProvider.notifier)
                                            .socialLogin(data: sData)
                                            .then((value) {
                                          if (value != null) {
                                            if (value.data?.user
                                                        ?.academicInfo ==
                                                    null ||
                                                value.data?.user
                                                        ?.subscription ==
                                                    null) {
                                              context.go(Routes.academicInfo);
                                            } else {
                                              context.go(Routes.dashboard);
                                            }
                                          } else {
                                            ref.invalidate(loginProvider);
                                          }
                                        });
                                      }
                                    });
                                  }
                                }).catchError((error) {
                                  // Handle error if needed
                                }).whenComplete(() {
                                  setState(() => _appleLoading = false);
                                });
                              },
                              child: _appleLoading
                                  ? const CircularProgressIndicator()
                                  : SvgPicture.asset(Assets.svgs.apple),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              Gap(24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).dontHaveAnAccount,
                    style: context.textTheme.bodyMedium!.copyWith(),
                  ),
                  Gap(8.w),
                  InkWell(
                    onTap: () {
                      context
                          .push(Routes.signup, extra: {'isDataFilled': false});
                    },
                    child: Text(
                      S.of(context).registerNow,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
