import 'package:flutter/material.dart';

class TimerBar extends StatefulWidget {
  final int totalSeconds;
  final VoidCallback onTimerComplete;

  const TimerBar({
    super.key,
    required this.totalSeconds,
    required this.onTimerComplete,
  });

  @override
  State<TimerBar> createState() => _TimerBarState();
}

class _TimerBarState extends State<TimerBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.totalSeconds),
    );

    _colorAnimation = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onTimerComplete();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TimerBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalSeconds != widget.totalSeconds) {
      _controller.dispose();
      _initAnimation(); // Restart animation on prop change
    }
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
      builder: (_, __) {
        double progress = 1 - _controller.value;

        return Stack(
          children: [
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width * progress,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        );
      },
    );
  }
}
