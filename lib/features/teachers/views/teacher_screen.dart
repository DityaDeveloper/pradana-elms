import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/message/views/enums.dart';
import 'package:lms/features/teachers/views/widgets/teacher_info_section.dart';
import 'package:lms/features/teachers/views/widgets/techersBG.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../generated/l10n.dart';

class TeacherScreen extends ConsumerStatefulWidget {
  const TeacherScreen(
      {super.key, required this.teacherId, required this.isParentView});

  final int teacherId;
  final bool? isParentView;

  @override
  ConsumerState<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends ConsumerState<TeacherScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Hive.box(AppConstants.authBox)
                  .get(AppConstants.authToken, defaultValue: null) !=
              null
          ? ref.read(messageControllerProvider.notifier).getMessages(
                instuctorId: widget.teacherId,
              )
          : null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherBG(
      bottomNav: widget.isParentView == true
          ? Material(
              borderRadius: BorderRadius.circular(32).r,
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(32).r,
                onTap: () => context.push(Routes.messageScreen, extra: {
                  'teacherId': widget.teacherId,
                  'senderType': SenderType.parent
                }),
                child: Container(
                  height: 45.r,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                          .r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32).r,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.svgs.messageQuestion,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(8.w),
                      Text(
                        S.of(context).askTeacher,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff0065FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      child: Column(
        children: [
          _headerSection(context),
          Gap(20.h),
          Expanded(
            child: SingleChildScrollView(
              child: TeacherInfoSection(
                teacherId: widget.teacherId,
                isParentView: widget.isParentView,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              ref.read(messageControllerProvider.notifier).clearMessages();
              context.pop();
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Localizations.localeOf(context).languageCode == 'ar'
                  ? Matrix4.rotationY(math.pi)
                  : Matrix4.identity(),
              child: SvgPicture.asset(
                Assets.svgs.arrowLeft,
              ),
            ),
          ),
          SizedBox(width: 24.w),
          Text(
            S.of(context).teacher,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
