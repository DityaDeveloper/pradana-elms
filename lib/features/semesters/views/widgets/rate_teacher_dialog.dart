import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class RateTeacherDialog extends ConsumerStatefulWidget {
  const RateTeacherDialog(
      {super.key, required this.teacherId, required this.courseId});

  final int teacherId;
  final int courseId;
  @override
  ConsumerState<RateTeacherDialog> createState() => _RateTeacherDialogState();
}

class _RateTeacherDialogState extends ConsumerState<RateTeacherDialog>
    with SingleTickerProviderStateMixin {
  double? rating;
  TextEditingController? reviewController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    reviewController = TextEditingController();
  }

  @override
  void dispose() {
    reviewController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.pngs.rate.image(height: 140.h),
                Gap(16.h),
                Text(
                  S.of(context).howWasTheCourse,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(12.h),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xffFFAB00),
                  ),
                  itemSize: 30.r,
                  onRatingUpdate: (rating) {
                    setState(() {
                      this.rating = rating;
                    });
                  },
                ),
                Gap(24.h),
                Text(
                  S.of(context).writeAboutWhat,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(16.h),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    maxLines: 3,
                    controller: reviewController,
                    decoration: InputDecoration(
                      hintText: S.of(context).writeHere,
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).enterSomeTxt;
                      }
                      return null;
                    },
                  ),
                ),
                Gap(16.h),
                Consumer(
                  builder: (context, ref, child) {
                    final loading = ref.watch(rateTeacherProvider);
                    return loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            title: S.of(context).submit,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(rateTeacherProvider.notifier)
                                    .rateTeacher({
                                  "instructor_id": widget.teacherId,
                                  "rating": rating ?? 5,
                                  "comment": reviewController?.text ?? '',
                                  "course_id": widget.courseId
                                }).then((value) {
                                  if (value == true) {
                                    ref
                                        .watch(isLockedLastSemesterProvider
                                            .notifier)
                                        .state = true;
                                    GlobalFunction.showCustomSnackbar(
                                      message: S.of(context).successFullyAdd,
                                      isSuccess: true,
                                    );
                                    context.push(Routes.dashboard);
                                  }
                                });
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.whiteColor,
                          );
                  },
                )
              ],
            ),
          ),
        ),
        // close button
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
