import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:quiz/modal/modal.dart';
import 'package:quiz/view/login/login.logged.screen.dart';
import 'package:quiz/view/login/score.board.widget.dart';
import 'package:quiz/view/utils/utils.dart';
import 'package:quiz/view_modal/view_modal.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
    return (context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginBloc()),
            BlocProvider(create: (context) => HistoryBloc()),
            BlocProvider(create: (context) => QuizBloc()),
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
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (blocCtx, blocState) {
          if (blocState is LoginSuccess) {
            return Column(
              children: const [
                Expanded(flex: 2, child: ScoreBoardWidget()),
                Expanded(flex: 1, child: LoginLoggedScreen()),
              ],
            );
          }
          return LoginScreenProvider(
              (authStateChangeActionCtx, authStateChangeActionAuthState) {
            if (authStateChangeActionAuthState is SignedIn) {
              // Changing state from signin to start quiz
              authStateChangeActionCtx
                  .read<LoginBloc>()
                  .add(LoginRequestedEvent());
              RepositoryProvider.of<CentralRepository>(context)
                  .getHistoryList()
                  .then((historyList) => authStateChangeActionCtx
                      .read<HistoryBloc>()
                      .add(HistoryDataRequested(historyList)));
            }
          });
        },
      ),
    );
  }
}
