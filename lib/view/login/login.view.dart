import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/view/login/login.bloc.builder.dart';
import 'package:quiz/view/login/score.board.widget.dart';
import 'package:quiz/view/utils/utils.dart';
import 'package:quiz/view_modal/view_modal.dart';

typedef FutureVoidCallback = Future<void> Function();

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
    return (context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginBloc()),
            BlocProvider(create: (context) => HistoryBloc()),
          ],
          child: const LoginView(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const DynamicAppBar(),
      ),
      body: Column(
        children: const [
          Expanded(
            flex: 1,
            child: ScoreBoardWidget(),
          ),
          Expanded(
            flex: 1,
            child: LoginBlocBuilderWidget(),
          ),
        ],
      ),
    );
  }
}
