import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/home/models/home_model/instructor.dart';
import 'package:lms/features/profile/logic/language_controller_hive.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class BestTeacherSection extends ConsumerWidget {
  const BestTeacherSection({
    super.key,
    required this.instructorList,
  });

  final List<Instructor>? instructorList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 0, bottom: 16).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: ref.watch(localeProvider).languageCode == "en"
                    ? const EdgeInsets.only(left: 16).r
                    : const EdgeInsets.only(right: 16).r,
                child: Text(
                  S.of(context).bestTeacher,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16).r,
                child: InkWell(
                  onTap: () {
                    context.push(Routes.teacherList);
                  },
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: instructorList == null || instructorList!.isEmpty
                ? Text(S.of(context).noTeacherFound)
                : Row(
                    children: List.generate(
                      instructorList!.length,
                      (index) => InkWell(
                        onTap: () {
                          context.push(
                            Routes.teachers,
                            extra: {
                              'teacherId': instructorList![index].id,
                              'isParentView': false,
                            },
                          );
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(6).r,
                          width: 160.w,
                          clipBehavior: Clip.antiAlias,
                          margin: ref.watch(localeProvider).languageCode == "en"
                              ? const EdgeInsets.only(left: 12).r
                              : const EdgeInsets.only(right: 12).r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: context.isDarkMode
                                ? AppColors.darkPrimaryColor
                                : Colors.white,
                            border: Border.all(
                              color: context.isDarkMode
                                  ? AppColors.darkPrimaryColor
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 125.r,
                                      width: 142.w,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      // child: Image.asset(
                                      //   "assets/pngs/image.png",
                                      //   fit: BoxFit.cover,
                                      // ),
                                      child: CachedNetworkImage(
                                        imageUrl: instructorList![index]
                                                .profilePicture ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Stack(
                                        children: [
                                          CustomPaint(
                                            size: Size(55.w, 25.h),
                                            painter: RPSCustomPainter(
                                              color: context.isDarkMode
                                                  ? AppColors.darkPrimaryColor
                                                  : Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Gap(Localizations.localeOf(
                                                              context)
                                                          .languageCode ==
                                                      'ar'
                                                  ? 12.w
                                                  : 0.w),
                                              Assets.pngs.star.image(
                                                  width: 14.r, height: 14.r),
                                              Gap(2.w),
                                              Text(
                                                (instructorList![index]
                                                            .averageRating ??
                                                        '')
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Gap(8.h),
                                Text(
                                  instructorList![index].name ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  instructorList![index].title ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff5D5D5D),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.cubicTo(
        size.width * 0.0008667,
        size.height * 0.8836500,
        size.width * 0.0246667,
        size.height * 0.7522500,
        size.width * 0.1666667,
        size.height * 0.7500000);
    path_0.cubicTo(
        size.width * 0.2915583,
        size.height * 0.7495625,
        size.width * 0.5412333,
        size.height * 0.7495000,
        size.width * 0.6662333,
        size.height * 0.7482500);
    path_0.cubicTo(
        size.width * 0.7906333,
        size.height * 0.7494000,
        size.width * 0.8331000,
        size.height * 0.7002500,
        size.width * 0.8337667,
        size.height * 0.5006500);
    path_0.cubicTo(
        size.width * 0.8336583,
        size.height * 0.4379875,
        size.width * 0.8334417,
        size.height * 0.3126625,
        size.width * 0.8333333,
        size.height * 0.2500000);
    path_0.cubicTo(size.width * 0.8295667, size.height * 0.1485500,
        size.width * 0.8220667, size.height * 0.0051500, size.width, 0);
    path_0.quadraticBezierTo(size.width * 0.7500000, 0, 0, 0);
    path_0.quadraticBezierTo(0, size.height * 0.2500000, 0, size.height);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    Paint paintStroke0 = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
