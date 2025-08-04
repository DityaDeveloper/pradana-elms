import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/dashboard/logic/providers.dart';
import 'package:lms/features/home/views/home_screen.dart';
import 'package:lms/features/profile/views/profile_screen.dart';
import 'package:lms/features/progress/views/student_view_progress_screen.dart';
import 'package:lms/features/search/search_screen.dart';
import 'package:lms/features/shop/views/shop_screen.dart';

import '../../generated/l10n.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({super.key});

  List<Map<String, dynamic>> getBottomItems(BuildContext context) {
    return [
      {
        "title": S.of(context).home,
        "icon": "assets/svgs/home.svg",
        "active_icon": "assets/svgs/home_active.svg",
      },
      {
        "title": S.of(context).search,
        "icon": "assets/svgs/search.svg",
        "active_icon": "assets/svgs/search_active.svg",
      },
      {
        "title": S.of(context).progress,
        "icon": "assets/svgs/progress.svg",
        "active_icon": "assets/svgs/progress_active.svg",
      },
      {
        "title": S.of(context).profile,
        "icon": "assets/svgs/user.svg",
        "active_icon": "assets/svgs/user_active.svg",
      },
    ];
  }

  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const StudentViewProgressScreen(),
    const ProfileScreen(),
    const ShopScreen()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationIndexProvider);
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: screens[currentIndex],
      extendBody: true,
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(
              double.infinity,
              // Platform.isIOS ? 150.h : 120.h,
              Platform.isIOS ? 106.h : 75.h,
            ),
            painter: RPSCustomPainter(
              fillColor: context.isDarkMode
                  ? AppColors.darkPrimaryColor
                  : Colors.white,
            ),
          ),
          Positioned(
            // top: Platform.isIOS ? 82.h : 75.h,
            top: Platform.isIOS ? 28.h : 24.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                getBottomItems(context).length + 1,
                (index) {
                  int actualIndex = index > 2 ? index - 1 : index;
                  if (index == 2) {
                    return SizedBox(
                      width: 10.w,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      ref.read(bottomNavigationIndexProvider.notifier).state =
                          actualIndex;
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(2).r,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            actualIndex == currentIndex
                                ? getBottomItems(context)[actualIndex]
                                    ['active_icon']
                                : getBottomItems(context)[actualIndex]['icon'],
                            height: 24.h,
                            colorFilter: ColorFilter.mode(
                                actualIndex == currentIndex
                                    ? AppColors.primaryColor
                                    : const Color(0xffB0B0B0),
                                BlendMode.srcIn),
                          ),
                          Gap(6.h),
                          Text(
                            getBottomItems(context)[actualIndex]['title'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: actualIndex == currentIndex
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: actualIndex == currentIndex
                                  ? AppColors.primaryColor
                                  : const Color(0xffB0B0B0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            // top: Platform.isIOS ? 56.h : 40.h,
            top: -8,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // ref.read(bottomNavigationIndexProvider.notifier).state = 4;
                context.push(Routes.shopScreen);
              },
              child: Container(
                height: 56.h,
                width: 56.w,
                padding: const EdgeInsets.all(14).r,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(.3),
                        offset: const Offset(0, 2),
                        blurRadius: 5,
                        spreadRadius: 3,
                      ),
                    ]),
                child: currentIndex == 4
                    ? SvgPicture.asset('assets/svgs/shop_active.svg')
                    : SvgPicture.asset('assets/svgs/shop.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final Color fillColor;
  RPSCustomPainter({required this.fillColor});
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0002750, size.height * 0.9942000);
    path_0.lineTo(size.width * 0.0008500, size.height);
    path_0.quadraticBezierTo(size.width * 0.0002125, size.height * 0.5500000, 0,
        size.height * 0.4000000);
    path_0.cubicTo(
        size.width * -0.0013000,
        size.height * 0.1568000,
        size.width * -0.0020000,
        size.height * 0.0108000,
        size.width * 0.1000000,
        0);
    path_0.cubicTo(
        size.width * 0.1998750,
        size.height * 0.0047000,
        size.width * 0.2002250,
        size.height * 0.1951000,
        size.width * 0.5024250,
        size.height * 0.2649000);
    path_0.cubicTo(
        size.width * 0.7997250,
        size.height * 0.1872000,
        size.width * 0.7986750,
        size.height * 0.0086000,
        size.width * 0.8996750,
        0);
    path_0.cubicTo(
        size.width * 1.0019250,
        size.height * 0.0068000,
        size.width * 1.0007000,
        size.height * 0.1447000,
        size.width * 1.0006000,
        size.height * 0.3977000);
    path_0.quadraticBezierTo(size.width * 1.0005187, size.height * 0.5468250,
        size.width * 1.0002750, size.height * 0.9942000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class RPSCustomPainter extends CustomPainter {
//   final Color fillColor;
//   RPSCustomPainter({required this.fillColor});
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Layer 1

//     Paint paintFill0 = Paint()
//       ..color = fillColor
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_0 = Path();
//     path_0.moveTo(size.width * 0.0006333, size.height * 0.9992500);
//     path_0.lineTo(size.width * 0.0000889, size.height * 0.2868333);
//     path_0.quadraticBezierTo(size.width * 0.0532000, size.height * 0.0125833,
//         size.width * 0.1102889, size.height * 0.0010833);
//     path_0.cubicTo(
//         size.width * 0.1656778,
//         size.height * 0.0045000,
//         size.width * 0.1668889,
//         size.height * 0.0407500,
//         size.width * 0.2349778,
//         size.height * 0.1339167);
//     path_0.quadraticBezierTo(size.width * 0.2783000, size.height * 0.2084167,
//         size.width * 0.5013111, size.height * 0.2706667);
//     path_0.quadraticBezierTo(size.width * 0.7212000, size.height * 0.1880833,
//         size.width * 0.7678667, size.height * 0.1340833);
//     path_0.cubicTo(
//         size.width * 0.8312889,
//         size.height * 0.0789167,
//         size.width * 0.8324000,
//         size.height * 0.0273333,
//         size.width * 0.8888333,
//         size.height * 0.0043333);
//     path_0.quadraticBezierTo(size.width * 0.9448222, size.height * 0.0112500,
//         size.width * 0.9996556, size.height * 0.2805000);
//     path_0.lineTo(size.width * 0.9998889, size.height * 0.9873333);

//     canvas.drawPath(path_0, paintFill0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
