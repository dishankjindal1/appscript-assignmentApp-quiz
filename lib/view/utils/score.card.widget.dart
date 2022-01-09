import 'package:flutter/material.dart';

class ScoreCardWidget extends StatelessWidget {
  ScoreCardWidget(String scoreObject, {Key? key})
      : super(
          key: key,
        ) {
    _score = int.parse(scoreObject);
  }

  late final int _score;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, true),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 250,
            color: Colors.blue[300],
            child: Card(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: Text('Your total score is $_score')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
