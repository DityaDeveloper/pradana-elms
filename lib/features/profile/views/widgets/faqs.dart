import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';

import '../../../../generated/l10n.dart';

class FAQSScreen extends ConsumerWidget {
  const FAQSScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? AppColors.darkScaffoldColor
          : const Color(0xffF6F6F6),
      body: Column(
        children: [
          _headerSection(context),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: ref.watch(fAQsProvider).when(
                  data: (faqList) {
                    return faqList == null
                        ? const Center(
                            child: Text("No data found"),
                          )
                        : Column(
                            children: List.generate(
                              faqList.length,
                              (index) => Column(
                                children: [
                                  CustomExpansionTile(
                                    title: faqList[index].question ?? '',
                                    content: faqList[index].answer ?? '',
                                  ),
                                  Gap(10.h),
                                ],
                              ),
                            ),
                          );
                  },
                  error: (error, stack) => Center(
                    child: Text(
                      error.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ))
        ],
      ),
    );
  }

  CommonAppbarWithBg _headerSection(BuildContext context) {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).fAQs,
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

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
      child: Card(
        color: context.cardColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _isExpanded ? Colors.blue : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textTheme.bodyLarge?.color!),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)
                        .r,
                child: Text(
                  widget.content,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
