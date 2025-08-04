import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lms/gen/assets.gen.dart';

class QuizTimerWidget extends StatefulWidget {
  final int duration;
  final Function(bool) startTimer;
  final Function(bool) pauseTimer;
  final Function(bool) onTimerEnded;
  final Function(String) onTimerChanged;

  const QuizTimerWidget({
    super.key,
    required this.duration,
    required this.startTimer,
    required this.pauseTimer,
    required this.onTimerEnded,
    required this.onTimerChanged,
  });

  @override
  QuizTimerWidgetState createState() => QuizTimerWidgetState();
}

class QuizTimerWidgetState extends State<QuizTimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Duration> _timerAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: widget.duration),
    );

    _timerAnimation = Tween<Duration>(
      begin: Duration(minutes: widget.duration),
      end: Duration.zero,
    ).animate(_controller)
      ..addListener(() {
        if (_controller.isCompleted) {
          widget.onTimerEnded(true);
        }
      });

    startTimer();
  }

  void startTimer() {
    widget.startTimer(true);
    _controller.forward();
  }

  void pauseTimer() {
    widget.pauseTimer(true);
    _controller.stop();
  }

  void resetTimer() {
    _controller.reset();
    startTimer();
  }

  void getCurrentTime() {
    String time = '';
    int min = _timerAnimation.value.inMinutes;
    int sec = _timerAnimation.value.inSeconds % 60;
    if (min == 0) {
      time = '$sec seconds';
    } else if (sec == 0) {
      time = '$min minutes';
    } else {
      time = '$min minutes $sec seconds';
    }

    widget.onTimerChanged(time);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final timeRemaining = _timerAnimation.value;
        final seconds = timeRemaining.inSeconds;

        return Container(
          padding: const EdgeInsets.only(top: 4, left: 12, right: 4, bottom: 4),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFE0F0FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: LinearProgressIndicator(
                  minHeight: 12.h,
                  backgroundColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF0B9AEC)),
                  value: 1.0 - _controller.value,
                ),
              ),
              const Gap(8),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 4, left: 8, right: 6, bottom: 4),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            '$seconds',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const Gap(4),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Center(
                          child: SvgPicture.asset(Assets.svgs.timer),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
