import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/modal.dart';
import 'package:quiz/view/login/login.logged.screen.dart';
import 'package:quiz/view/utils/ciruular.indicator.widget.dart';
import 'package:quiz/view/utils/login.provider.screen.dart';
import 'package:quiz/view/utils/score.card.widget.dart';
import 'package:quiz/view_modal/view_modal.dart';

typedef FutureVoidCallback = Future<void> Function();

class LoginBlocBuilderWidget extends StatelessWidget {
  const LoginBlocBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (blocContext, blocState) {
        // If the LoginBloc has initial state of LoginSuccess
        // Listen bloc will not execute
        // It will on execute on the runtime changes
        if (blocState is LoginSuccess) {
          var score = Navigator.of(context).pushNamed('/quiz');
          // We passed in Future data to a function
          // The method Fn will be responsible for
          // fetching the score and sending the request to bloc
          // bloc will do whatever it wants to do
          _getPopData(context, score);
        }

        if (blocState is LogoutSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Signed Out')));
          context.read<HistoryBloc>().add(HistoryClearRequested());
        }

        if (blocState is LoginInitial) {
          context.read<HistoryBloc>().add(HistoryClearRequested());
        }
      },
      builder: (blocContext, blocState) {

        if (blocState is LoginInitial || blocState is LogoutSuccess) {
          return LoginScreenProvider(() {
            // Changing state from signin to start quiz
            context.read<LoginBloc>().add(LoginRequestedEvent());
          });
        }
        if (blocState is LoginSuccess) {
          // // Updating scoreboard
          _updateHistoryList(context);

          return const LoginLoggedScreen();
        }
        if (blocState is LoginSuccessScore) {
          // Updating scoreboard
          _updateHistoryList(context);

          return LoginLoggedScreen(
            score: blocState.score,
          );
        }

        
        return const CenteredCircularIndicator();
      },
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
