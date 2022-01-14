import 'package:flutter/material.dart';
import 'package:quiz/view/home/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget initPage(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 2, child: ScoreBoard.initPage(context)),
        const Expanded(flex: 1, child: PanelWidget()),
      ],
    );
  }
}
