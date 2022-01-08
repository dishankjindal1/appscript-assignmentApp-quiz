import 'package:flutter/material.dart';

typedef AnimationCallBackFunc = void Function(AnimationController);
class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar(this.animateProgress, {Key? key}) : super(key: key);

  final AnimationCallBackFunc animateProgress;



  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationCallBackFunc _animateProgress;

  @override
  void initState() {
    super.initState();
    _animateProgress = widget.animateProgress;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      animationBehavior: AnimationBehavior.preserve,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    );
    _animateProgress(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, widget) {
        return Center(
          child: LinearProgressIndicator(
            value: _animation.value,
          ),
        );
      },
    );
  }
}
