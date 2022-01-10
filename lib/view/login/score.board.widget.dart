import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/modal.dart';
import 'package:quiz/view_modal/view_modal.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class ScoreBoardWidget extends StatelessWidget {
  const ScoreBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (historyCtx, historyState) {
        if (historyState is HistoryData) {
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                var historyList =
                    await RepositoryProvider.of<CentralRepository>(historyCtx)
                        .getHistoryList();
                historyCtx
                    .read<HistoryBloc>()
                    .add(HistoryDataRequested(historyList));
                await Future.delayed(const Duration(seconds: 1));
              },
              child: Column(
                children: [
                  ListTile(
                    tileColor: Colors.amber[300],
                    title: const Text(
                      'Your Scores',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  historyState.list.isNotEmpty
                      ? SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: historyState.list.length,
                            itemBuilder: (context, index) {
                              var data = historyState.list.elementAt(index);
                              var day = DateTime.parse(data.timestamp);
                              var time = TimeOfDay.fromDateTime(
                                  DateTime.parse(data.timestamp));

                              if (index.isEven) {
                                return ListTile(
                                  tileColor: index == 0
                                      ? Colors.green[200]
                                      : Colors.transparent,
                                  leading: const Icon(Icons.score),
                                  title: Text('You Scored ${data.score}'),
                                  subtitle: dateTimeWidget(day, time),
                                );
                              } else {
                                return ListTile(
                                  leading: const Icon(Icons.score),
                                  title: Text('You Scored ${data.score}'),
                                  subtitle: dateTimeWidget(day, time),
                                );
                              }
                            },
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Center(
                            child: MirrorAnimation<double>(
                              tween: Tween(begin: -0.1, end: 0.1),
                              duration: const Duration(seconds: 2),
                              builder: (mirrorAnimationCtx,
                                  mirrorAnimationWidget, mirrorAnimationTween) {
                                return Transform.rotate(
                                  angle: (mirrorAnimationTween),
                                  child: Transform.scale(
                                    scale: mirrorAnimationTween + 1,
                                    child: Image.asset(
                                      'assets/images/img-1.png',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        } else {
          // if historyState is HistoryState default case
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
                        'assets/images/img-1.png',
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Text dateTimeWidget(DateTime day, TimeOfDay time) => Text(
      'on ${day.day}/${day.month}/${day.year} ${time.hour}:${time.minute}');
}
