import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/exam/views/widgets/numer_text.dart';
import 'package:lms/generated/l10n.dart';

class ResultProgress extends StatefulWidget {
  final int totalMarks;
  final int obtainedMarks;
  const ResultProgress({
    super.key,
    required this.totalMarks,
    required this.obtainedMarks,
  });

  @override
  State<ResultProgress> createState() => _ResultProgressState();
}

class _ResultProgressState extends State<ResultProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    double end = widget.obtainedMarks / widget.totalMarks;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween(begin: 0.0, end: end).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Stack(
              children: [
                SizedBox(
                  height: 132.h,
                  width: 132.w,
                  child: CircularProgressIndicator(
                    value: _animation.value,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    strokeCap: StrokeCap.round,
                    strokeWidth: 12.r,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).youAchive,
                          style: context.textTheme.bodySmall),
                      NumberText(
                        targetNumber: widget.obtainedMarks,
                        style: context.textTheme.titleMedium,
                      ),
                      Text(
                          "${S.of(context).outOf} ${widget.totalMarks} ${S.of(context).marks}",
                          style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
