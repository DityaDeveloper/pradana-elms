import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/gen/assets.gen.dart';

class ExamBG extends StatelessWidget {
  const ExamBG({
    super.key,
    required this.child,
    this.bottomWidget,
  });
  final Widget child;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Assets.pngs.examBg.image(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
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
