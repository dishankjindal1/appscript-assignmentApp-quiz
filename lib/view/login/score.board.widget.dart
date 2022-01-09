import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/modal.dart';
import 'package:quiz/view_modal/view_modal.dart';

typedef FakeWidget = SizedBox;

class ScoreBoardWidget extends StatefulWidget {
  const ScoreBoardWidget({Key? key}) : super(key: key);

  @override
  State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (historyCtx, historyState) {
        if (historyState is HistoryData) {
          return RefreshIndicator(
            onRefresh: () async {
              var historyList =
                  await RepositoryProvider.of<CentralRepository>(context)
                      .getHistoryList();
              context
                  .read<HistoryBloc>()
                  .add(HistoryDataRequested(historyList));
              await Future.delayed(const Duration(seconds: 1));
              setState(() {});
            },
            child: ListView.builder(
              itemCount: historyState.list.length + 1,
              itemBuilder: (context, index) {
                if (historyState.list.isEmpty) {
                  return const FakeWidget();
                }
                // Work Around for adding header on the to of list
                // Must decrement index by 1 index--
                if (index == 0) {
                  return ListTile(
                    tileColor: Colors.amber[300],
                    title: const Text(
                      'Your Scores',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                index--;

                var data = historyState.list.elementAt(index);
                var day = DateTime.parse(data.timestamp);
                var time =
                    TimeOfDay.fromDateTime(DateTime.parse(data.timestamp));

                if (index.isEven) {
                  return ListTile(
                    leading: const Icon(Icons.score),
                    title: Text('You Scored ${data.score}'),
                    subtitle: dateTimeWidget(day, time),
                  );
                } else {
                  return ListTile(
                    tileColor: Colors.grey[300],
                    leading: const Icon(Icons.score),
                    title: Text('You Scored ${data.score}'),
                    subtitle: dateTimeWidget(day, time),
                  );
                }
              },
            ),
          );
        } else {
          // if historyState is HistoryState default case
          return Container();
        }
      },
    );
  }

  Text dateTimeWidget(DateTime day, TimeOfDay time) => Text(
      'on ${day.day}/${day.month}/${day.year} ${time.hour}:${time.minute}');
}
