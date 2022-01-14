import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/repository.dart';
import 'package:quiz/view/home/home.screen.dart';
import 'package:quiz/view/utils/utils.dart';
import 'package:quiz/view_modal/view_modal.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
    _centralRepository(BuildContext buildCtx) =>
        RepositoryProvider.of<CentralRepository>(buildCtx);

    return (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => LoginBloc(_centralRepository(context))),
            BlocProvider(
                create: (context) => HistoryBloc(_centralRepository(context))),
            BlocProvider(
                create: (context) => QuizBloc(_centralRepository(context))),
          ],
          child: const LoginView(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (blocCtx, blocState) {
        if (blocState is LoadingState) {
          return const CenteredCircularIndicator();
        }
        if (blocState is LoginSuccess) {
          return HomeScreen.initPage(blocCtx);
        }
        return LoginScreen.initPage(blocCtx);
      },
    );
  }
}
