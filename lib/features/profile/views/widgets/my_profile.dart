import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:lms/features/profile/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});

  Future<void> pickImage(WidgetRef ref) async {
    final imagePicker = ref.read(imagePickerProvider.notifier);
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imagePicker.state = pickedFile;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(context),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 180.h,
                width: double.infinity,
                child: SvgPicture.asset(
                  Assets.svgs.rec,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    context.cardColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: Hive.box(AppConstants.authBox).listenable(),
                  builder: (context, box, _) {
                    return Stack(
                      children: [
                        Container(
                          height: 130.r,
                          width: 130.r,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: ref.watch(imagePickerProvider) != null
                              ? Image.file(
                                  File(ref.watch(imagePickerProvider)!.path),
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: box.get(AppConstants.userData,
                                          defaultValue:
                                              null)?['profile_picture'] ??
                                      '',
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 10,
                          child: InkWell(
                            onTap: () async {
                              await pickImage(ref);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4).r,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18.r,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  })
            ],
          ),
          Gap(12.h),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.containerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  _buttonSection(context),
                  Expanded(
                    child: ref.watch(isPersonalInfoFormViewProvider)
                        ? const PersonalInfoForm()
                        : const AcademicInfoForm(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonSection(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isPersonalInfoFormView =
            ref.watch(isPersonalInfoFormViewProvider);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4).r,
          margin: const EdgeInsets.all(16).r,
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
                    ref.read(isPersonalInfoFormViewProvider.notifier).state =
                        true;
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isPersonalInfoFormView
                          ? context.containerColor
                          : null,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      S.of(context).personalInfo,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 13.sp,
                        color: isPersonalInfoFormView
                            ? AppColors.primaryColor
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => ref
                      .read(isPersonalInfoFormViewProvider.notifier)
                      .state = false,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isPersonalInfoFormView
                          ? null
                          : context.containerColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      S.of(context).academicInfo,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 13.sp,
                        color: isPersonalInfoFormView
                            ? null
                            : AppColors.primaryColor,
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

  CommonAppbarWithBg _headerSection(BuildContext context) {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).myProfile,
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

class PersonalInfoForm extends ConsumerStatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  ConsumerState<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends ConsumerState<PersonalInfoForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: FormBuilder(
              key: _formKey,
              initialValue: {
                "name": box.get(AppConstants.userData,
                        defaultValue: null)?['name'] ??
                    '',
                "email": box.get(AppConstants.userData,
                        defaultValue: null)?['email'] ??
                    '',
                "phone": box.get(AppConstants.userData,
                        defaultValue: null)?['phone'] ??
                    '',
                "parent_phone": box.get(AppConstants.userData,
                        defaultValue: null)?['parent_phone'] ??
                    '',
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(6.h),
                    FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(
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
                      decoration: InputDecoration(
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
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
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
                    Gap(24.h),
                    Consumer(
                      builder: (context, ref, child) {
                        final loading = ref.watch(profileUpdateProvider);
                        return loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: context.cardColor,
                                  foregroundColor: AppColors.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.w, vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(54.r),
                                    side: const BorderSide(
                                        color: AppColors.primaryColor),
                                  ),
                                  minimumSize: Size(double.infinity, 60.h),
                                ),
                                onPressed: () async {
                                  bool isFormValid =
                                      _formKey.currentState!.saveAndValidate();

                                  String? pickedImage =
                                      ref.read(imagePickerProvider)?.path;

                                  final formData = {
                                    ..._formKey.currentState!.value,
                                  };

                                  if (pickedImage != null && isFormValid) {
                                    MultipartFile img =
                                        await MultipartFile.fromFile(
                                            pickedImage);
                                    ref
                                        .read(profileUpdateProvider.notifier)
                                        .updateProfile(data: {
                                      ...formData,
                                      "profile_picture": img,
                                    }).then((value) {
                                      if (value == true) {
                                        GlobalFunction.showCustomSnackbar(
                                            message:
                                                "Profile updated successfully",
                                            isSuccess: true);
                                      } else {
                                        GlobalFunction.showCustomSnackbar(
                                            message: "Profile update failed",
                                            isSuccess: false);
                                      }
                                    });
                                  } else if (isFormValid) {
                                    ref
                                        .read(profileUpdateProvider.notifier)
                                        .updateProfile(data: formData)
                                        .then((value) {
                                      if (value == true) {
                                        GlobalFunction.showCustomSnackbar(
                                            message:
                                                "Profile updated successfully",
                                            isSuccess: true);
                                      } else {
                                        GlobalFunction.showCustomSnackbar(
                                            message: "Profile update failed",
                                            isSuccess: false);
                                      }
                                    });
                                  } else {
                                    // No changes or form is invalid
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'No changes to update or form is invalid')),
                                    );
                                  }
                                },
                                child: Text(
                                  S.of(context).update,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class AcademicInfoForm extends StatefulWidget {
  const AcademicInfoForm({super.key});

  @override
  State<AcademicInfoForm> createState() => _AcademicInfoFormState();
}

class _AcademicInfoFormState extends State<AcademicInfoForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            child: FormBuilder(
              key: _formKey,
              initialValue: {
                "country": box.get(AppConstants.academinInfoData,
                        defaultValue: null)?['country'] ??
                    '',
                "grade": box.get(AppConstants.academinInfoData,
                        defaultValue: null)?['grade'] ??
                    '',
                "school_type": box.get(AppConstants.academinInfoData,
                        defaultValue: null)?['school_type'] ??
                    '',
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(5.h),
                    FormBuilderTextField(
                      name: "country",
                      readOnly: true,
                      onTap: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        suffix: SvgPicture.asset(
                          Assets.svgs.arrowDown,
                          height: 20.r,
                        ),
                        label: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(S.of(context).country),
                            Gap(6.w),
                            SvgPicture.asset(
                              Assets.svgs.star,
                              height: 8.r,
                            )
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(checkNullOrEmpty: false),
                      ]),
                    ),
                    Gap(24.h),
                    FormBuilderTextField(
                      name: "grade",
                      readOnly: true,
                      onTap: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        suffix: SvgPicture.asset(
                          Assets.svgs.arrowDown,
                          height: 20.r,
                        ),
                        label: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(S.of(context).grade),
                            Gap(6.w),
                            SvgPicture.asset(
                              Assets.svgs.star,
                              height: 8.r,
                            )
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(checkNullOrEmpty: false),
                      ]),
                    ),
                    Gap(24.h),
                    FormBuilderTextField(
                      name: "school_type",
                      onTap: () => FocusScope.of(context).unfocus(),
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withOpacity(0.1),
                        filled: true,
                        suffix: SvgPicture.asset(
                          Assets.svgs.arrowDown,
                          height: 20.r,
                        ),
                        label: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(S.of(context).schoolType),
                            Gap(6.w),
                            SvgPicture.asset(
                              Assets.svgs.star,
                              height: 8.r,
                            )
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(checkNullOrEmpty: false),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
