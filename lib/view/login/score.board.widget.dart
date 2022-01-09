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
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  tileColor: Colors.amber[300],
                  title: const Text(
                    'Your Scores',
                    textAlign: TextAlign.center,
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    var historyList =
                        await RepositoryProvider.of<CentralRepository>(context)
                            .getHistoryList();
                    context
                        .read<HistoryBloc>()
                        .add(HistoryDataRequested(historyList));
                    await Future.delayed(const Duration(seconds: 1));
                    // setState(() {});
                  },
                  child: SizedBox(
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
                  ),
                ),
              ],
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
