import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:quiz/view_modal/view_modal.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget initPage(BuildContext context) {
    return const SafeArea(child: Scaffold(body: LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: OverflowBox(
            minWidth: MediaQuery.of(context).size.width,
            child: const ColoredBox(
              color: Colors.blueGrey,
              child: Center(
                child: Text(
                  'Quiz Bee India Edition',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId:
                      '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com'),
              AppleProviderConfiguration(),
            ],
            actions: [
              // SignedOutAction((BuildContext signedoutCtx) {
              //   Scaffold.of(signedoutCtx).showBodyScrim(true, 0.5);
              // }),
              AuthStateChangeAction((currectContext, currentState) {
                if (currentState is SignedIn) {
                  // Changing state from signin to start quiz
                  currectContext
                      .read<HistoryBloc>()
                      .add(const HistoryDataRequested());
                }
                if (currentState is SigningIn) {
                  currectContext.read<LoginBloc>().add(LoginEventRequested());
                }
              }),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
