import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/modal.dart';
import 'package:quiz/view/utils/utils.dart';
import 'package:quiz/view_modal/view_modal.dart';

class LoginLoggedScreen extends StatelessWidget {
  const LoginLoggedScreen({Key? key, this.score = -1}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    // The minimum score is 0 and the Max is 100
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // if score has some value then show score
          score >= 0 ? Text('Your total score is $score') : const SizedBox(),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(100, 50))),
                onPressed: () {
                  var futureListOfQuestion =
                      RepositoryProvider.of<CentralRepository>(context)
                          .getQuestionList();
                  context
                      .read<QuizBloc>()
                      .add(QuizStartRequested(futureListOfQuestion));
                  var score = Navigator.of(context).pushNamed('/quiz');
                  _getPopData(context, score);
                },
                child: const Text('Start Quiz'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(100, 50))),
                onPressed: () {
                  context.read<LoginBloc>().add(LogoutRequestedEvent());
                  context.read<HistoryBloc>().add(HistoryClearRequested());
                },
                child: const Text('Sign out'),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  _getPopData(BuildContext context, Future<dynamic> data) async {
    // converting the Future[data] into a Map Object
    Map<String, dynamic>? scoreObject = await data;
    // for debugging purporse to print the score
    // debugPrint(scoreObject['score'].toString());

    try {
      // uploading the score to firestore
      await RepositoryProvider.of<CentralRepository>(context)
          .uploadScores(scoreObject?['score'].toString() ?? '-1');
    } catch (e) {
      debugPrint(e.toString());
    }

    if (scoreObject != null) {
      _finalScorePopUp(context, scoreObject['score'].toString()).then((value) {
        // updating the state by requesting score data
        // context.read<LoginBloc>().add(LoginScoreRequestedEvent(scoreObject['score']));
        _updateHistoryList(context);
      });
    }

    await _updateHistoryList(context);
  }

  _updateHistoryList(BuildContext context) async {
    // Looking to update on every screen pop
    var historyList = await RepositoryProvider.of<CentralRepository>(context)
        .getHistoryList();
    context.read<HistoryBloc>().add(HistoryDataRequested(historyList));
  }

  Future<bool?> _finalScorePopUp(
      BuildContext context, String finalScorePopUpScore) async {
    return await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return ScoreCardWidget(finalScorePopUpScore);
      },
    );
  }
}
