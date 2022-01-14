import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/data/history/history.data.modal.dart';
import 'package:quiz/view/utils/utils.dart';
import 'package:quiz/view_modal/view_modal.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  static Widget initPage(BuildContext context) {
    // Initalize the data fetching before we start build
    // It will not trigger History event on every build of this widget
    context.read<HistoryBloc>().add(const HistoryDataRequested());
    return const ScoreBoard();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (historyCtx, historyState) {
        if (historyState is HistoryData) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () => _refreshScoreBoard(context),
              child: Column(
                children: [
                  const ScoreBoardLabel('Your Score'),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: historyState.list.length,
                      itemBuilder: (context, index) {
                        var data = historyState.list.elementAt(index);
                        var day = DateTime.parse(data.timestamp);
                        var time = TimeOfDay.fromDateTime(
                            DateTime.parse(data.timestamp));

                        return ScoreBoardTile(
                            color: index == 0 ? Colors.green : index.isOdd ? Colors.grey : Colors.transparent,
                            data: data,
                            day: day,
                            time: time);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
        // if historyState is HistoryState default case
        return const DefaultHistoryStateWidget(
            imageUrl: 'assets/images/img-1.png');
      },
    );
  }

  Future<void> _refreshScoreBoard(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<HistoryBloc>().add(const HistoryDataRequested());
  }
}

class ScoreBoardTile extends StatelessWidget {
  const ScoreBoardTile({
    Key? key,
    required this.data,
    required this.day,
    required this.time,
    required this.color,
  }) : super(key: key);

  final Color? color;
  final HistoryDataModal data;
  final DateTime day;
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color,
      leading: const Icon(Icons.score),
      title: Text('You Scored ${data.score}'),
      subtitle: dateTimeWidget(day, time),
    );
  }
}

class DefaultHistoryStateWidget extends StatelessWidget {
  const DefaultHistoryStateWidget({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: MirrorAnimation<double>(
          tween: Tween(begin: -0.1, end: 0.1),
          duration: const Duration(seconds: 2),
          builder: (mirrorAnimationCtx, mirrorAnimationWidget,
              mirrorAnimationTween) {
            return Transform.rotate(
              angle: (mirrorAnimationTween),
              child: Transform.scale(
                scale: mirrorAnimationTween + 1,
                child: Image.asset(
                  imageUrl,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ScoreBoardLabel extends StatelessWidget {
  const ScoreBoardLabel(
    this.label, {
    Key? key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.amber[300],
      title: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}
