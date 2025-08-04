import 'package:flutter/material.dart';

class NumberText extends StatefulWidget {
  final int targetNumber; // The target number to animate to
  final Duration duration; // Duration of the animation
  final TextStyle? style;

  const NumberText({
    super.key,
    required this.targetNumber,
    this.duration = const Duration(seconds: 1),
    this.style,
  });

  @override
  _NumberTextState createState() => _NumberTextState();
}

class _NumberTextState extends State<NumberText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Create Tween for integer animation
    _animation = IntTween(begin: 0, end: widget.targetNumber).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _animation.value.toString(),
          style: widget.style,
        );
      },
    );
  }
}
