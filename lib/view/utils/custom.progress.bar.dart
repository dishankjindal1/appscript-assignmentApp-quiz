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
  int progressPercentage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      animationBehavior: AnimationBehavior.preserve,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.00, 1.00, curve: Curves.linear),
    );
    widget.animateProgress(_controller);
    _animation.addListener(() {
      setState(() {
        progressPercentage = (_animation.value * 100).toInt();
      });
    });
  }

  @override
  void dispose() {
    // Order of Dispose matters
    _controller.dispose();
    _animation.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: const Alignment(0, 0),
            child: Text(
              '$progressPercentage %',
              style: const TextStyle(fontSize: 24),
            )),
        const SizedBox(height: 25),
        Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, widget) {
              return LinearProgressIndicator(
                value: _animation.value,
              );
            },
          ),
        ),
      ],
    );
  }
}
