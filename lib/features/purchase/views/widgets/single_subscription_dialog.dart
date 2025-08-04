import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class SingleSubscriptionDialog extends ConsumerStatefulWidget {
  const SingleSubscriptionDialog({super.key, required this.planName});

  final String planName;

  @override
  ConsumerState<SingleSubscriptionDialog> createState() =>
      _SingleSubscriptionDialogState();
}

class _SingleSubscriptionDialogState
    extends ConsumerState<SingleSubscriptionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.pngs.successdiaicon.image(height: 100.h),
              Gap(16.h),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    S.of(context).welcomTo,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.planName,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    S.of(context).plan,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              Text(
                S.of(context).youHaveSucc,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(16.h),
              CustomButton(
                title:
                    "${S.of(context).explore} ${widget.planName} ${S.of(context).features}",
                onPressed: () {
                  context.push(Routes.dashboard);
                },
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
              )
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              // top: _positionAnimation.value,
              top: 0,
              right: 0,
              left: 0,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Assets.pngs.celebration.image(
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
