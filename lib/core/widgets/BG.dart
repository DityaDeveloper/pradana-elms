import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/gen/assets.gen.dart';

class BG extends StatelessWidget {
  const BG(
      {super.key, required this.child, this.isRoot = true, this.bottomWidget});
  final Widget child;
  final bool isRoot;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        // statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: context.isDarkMode
            ? AppColors.darkPrimaryColor
            : Colors.transparent,
        // systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: !isRoot ? null : AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              child: isRoot
                  ? Assets.pngs.bg.image(
                      height: 340.h,
                      width: 300.w,
                      fit: BoxFit.fill,
                    )
                  : Assets.pngs.bg.image(
                      height: 340.h,
                      width: 300.w,
                      fit: BoxFit.fill,
                      // fit: BoxFit.fitHeight,
                    ),
            ),
          ),
          Positioned.fill(
            left: 0,
            top: 44.h,
            right: 0,
            child: child,
          ),
        ],
      ),
      bottomNavigationBar: bottomWidget,
    );
  }
}
