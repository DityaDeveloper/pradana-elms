import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/academic_info/logic/academic_controller.dart';
import 'package:lms/features/academic_info/logic/providers.dart';
import 'package:lms/features/academic_info/models/academic_info_model/country.dart';
import 'package:lms/features/academic_info/models/academic_info_model/grade.dart';
import 'package:lms/features/academic_info/models/academic_info_model/school_type.dart';
import 'package:lms/features/home/models/home_model/course.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class AcademicInfoScreen extends ConsumerStatefulWidget {
  const AcademicInfoScreen({super.key});

  @override
  ConsumerState<AcademicInfoScreen> createState() => _AcademicInfoScreenState();
}

class _AcademicInfoScreenState extends ConsumerState<AcademicInfoScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Course? selectedSubject;
  int? selectedCountryId;

  // List<dynamic> subjectList(context) => [
  //       {
  //         "title": S.of(context).gat,
  //         "icon": "assets/pngs/gat.png",
  //       },
  //       {
  //         "title": S.of(context).toefl,
  //         "icon": "assets/pngs/toefl.png",
  //       },
  //       {
  //         "title": S.of(context).ielts,
  //         "icon": "assets/pngs/ielts.png",
  //       }
  //     ];
  @override
  Widget build(BuildContext context) {
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
              child: Consumer(
                builder: (context, ref, child) {
                  final academicInfoAsync = ref.watch(academicInfoListProvider);
                  return academicInfoAsync.when(
                    data: (data) {
                      return SingleChildScrollView(
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(5.h),
                              FormBuilderDropdown(
                                name: "country",
                                items: data.data!.countries!.map((country) {
                                  return DropdownMenuItem(
                                    value: country,
                                    child: Text(
                                      country.name ?? '',
                                      style:
                                          context.textTheme.bodyLarge!.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCountryId = value?.id ?? 0;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  Assets.svgs.arrowDown,
                                  height: 20.r,
                                ),
                                decoration: InputDecoration(
                                  label: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              Gap(24.h),
                              selectedCountryId != null &&
                                      data.data!.grades!
                                              .firstWhere(
                                                  (grade) =>
                                                      grade.countryId ==
                                                      selectedCountryId,
                                                  orElse: () =>
                                                      Grade(id: 0, title: ''))
                                              .id ==
                                          0
                                  ? const Center(child: Text("No Grades found"))
                                  : FormBuilderDropdown(
                                      name: "grade",
                                      items: data.data!.grades!
                                          .where((grade) =>
                                              grade.countryId ==
                                              selectedCountryId)
                                          .map((grade) {
                                        return DropdownMenuItem(
                                          value: grade,
                                          child: Text(
                                            grade.title ?? '',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(fontSize: 14.sp),
                                          ),
                                        );
                                      }).toList(),
                                      icon: SvgPicture.asset(
                                        Assets.svgs.arrowDown,
                                        height: 20.r,
                                      ),
                                      decoration: InputDecoration(
                                        label: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                              Gap(24.h),
                              selectedCountryId != null &&
                                      data.data!.schoolTypes!
                                              .firstWhere(
                                                  (schoolType) =>
                                                      schoolType.countryId ==
                                                      selectedCountryId,
                                                  orElse: () => SchoolType(
                                                      id: 0, title: ''))
                                              .id ==
                                          0
                                  ? const Center(
                                      child: Text("No SchoolType found"))
                                  : FormBuilderDropdown(
                                      name: "schoolType",
                                      items: data.data!.schoolTypes!
                                          .where((schoolType) =>
                                              schoolType.countryId ==
                                              selectedCountryId)
                                          .map((schoolType) {
                                        return DropdownMenuItem(
                                          value: schoolType,
                                          child: Text(
                                            schoolType.title ?? '',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                              Gap(24.h),
                              Text(
                                S.of(context).chooseSub,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Gap(12.h),
                              Wrap(
                                spacing: 16.w,
                                runSpacing: 16.h,
                                children: List.generate(
                                  data.data!.courses!.length,
                                  (index) {
                                    final subjectList = data.data!.courses!;
                                    return Consumer(
                                      builder: (context, ref, child) {
                                        final currectSub =
                                            ref.watch(currentSubjectProvider);
                                        return InkWell(
                                          onTap: () {
                                            if (ref
                                                    .read(currentSubjectProvider
                                                        .notifier)
                                                    .state ==
                                                index) {
                                              ref
                                                  .read(currentSubjectProvider
                                                      .notifier)
                                                  .state = -1;
                                              setState(() {
                                                selectedSubject = null;
                                              });
                                            } else {
                                              ref
                                                  .read(currentSubjectProvider
                                                      .notifier)
                                                  .state = index;
                                              setState(() {
                                                selectedSubject =
                                                    subjectList[index];
                                              });
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 100.r,
                                                width: 100.r,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: currectSub == index
                                                      ? context.isDarkMode
                                                          ? AppColors
                                                              .primaryColor
                                                          : const Color(
                                                              0xffF0F8FF)
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                  border: Border.all(
                                                    color: currectSub == index
                                                        ? const Color(
                                                            0xff0B9AEC)
                                                        : AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 45.r,
                                                      width: 45.r,
                                                      // child: Image.network(
                                                      //   subjectList[index]
                                                      //           .thumbnail ??
                                                      //       '',
                                                      //   fit: BoxFit.contain,
                                                      // ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: subjectList[
                                                                    index]
                                                                .thumbnail ??
                                                            '',
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    Gap(5.h),
                                                    Text(
                                                      subjectList[index]
                                                              .title ??
                                                          '',
                                                      style: context
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                        fontSize: 12.sp,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Gap(32.h),
                              Consumer(
                                builder: (context, ref, child) {
                                  final loading =
                                      ref.watch(academicInfoStoreProvider);
                                  return loading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomButton(
                                          title: S.of(context).proceedNext,
                                          onPressed: () {
                                            // if (_formKey.currentState!
                                            //     .saveAndValidate()) {
                                            // Check if any of the dropdowns are selected
                                            Country? country = _formKey
                                                .currentState
                                                ?.fields["country"]
                                                ?.value;
                                            Grade? grade = _formKey.currentState
                                                ?.fields["grade"]?.value;
                                            SchoolType? schoolType = _formKey
                                                .currentState
                                                ?.fields["schoolType"]
                                                ?.value;
                                            // final selectedSubject = ref
                                            //     .read(currentSubjectProvider);

                                            if (country != null ||
                                                grade != null ||
                                                schoolType != null) {
                                              if (_formKey.currentState!
                                                  .saveAndValidate()) {
                                                // Store the data
                                                Map<String, dynamic> data = {
                                                  "country_id": country?.id,
                                                  "grade_id": grade?.id,
                                                  "school_type_id":
                                                      schoolType?.id,
                                                  "course_id":
                                                      selectedSubject?.id,
                                                };

                                                ref
                                                    .read(
                                                        academicInfoStoreProvider
                                                            .notifier)
                                                    .store(data)
                                                    .then((value) {
                                                  if (value == true) {
                                                    context.push(
                                                      Routes
                                                          .basicOrVipSubscription,
                                                      extra: selectedSubject,
                                                    );
                                                  }
                                                });
                                              }
                                            } else if (selectedSubject?.id !=
                                                null) {
                                              // Store the data
                                              Map<String, dynamic> data = {
                                                "country_id": country?.id,
                                                "grade_id": grade?.id,
                                                "school_type_id":
                                                    schoolType?.id,
                                                "course_id":
                                                    selectedSubject?.id,
                                              };

                                              ref
                                                  .read(
                                                      academicInfoStoreProvider
                                                          .notifier)
                                                  .store(data)
                                                  .then((value) {
                                                if (value == true) {
                                                  context.push(
                                                    Routes.singleSubscription,
                                                    extra: selectedSubject
                                                        as Course,
                                                  );
                                                }
                                              });
                                            } else {
                                              GlobalFunction.showCustomSnackbar(
                                                message:
                                                    "Please select at least one option",
                                                isSuccess: false,
                                              );
                                            }
                                            // }
                                          },
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: AppColors.whiteColor,
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stack) {
                      print(error);
                      print(stack);
                      return Center(
                        child: Text(
                          'Error: ${error.toString()}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
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
      child: Image.asset(
        Assets.pngs.logo.path,
        width: 50.w,
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
            S.of(context).academicInfo,
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          Gap(12.sp),
          Text(
            S.of(context).enterAcademicInfo,
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
