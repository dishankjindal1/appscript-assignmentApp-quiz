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
      curve: const Interval(0.0, 1.0, curve: Curves.linear),
    );
    widget.animateProgress(_controller);
  }

  @override
  void dispose() {
    // Order of Dispose matters
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      progressPercentage += 10;
    });
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
