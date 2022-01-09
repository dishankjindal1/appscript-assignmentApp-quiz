import 'package:flutter/material.dart';

class CenteredCircularIndicator extends StatelessWidget {
  const CenteredCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
