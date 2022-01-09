import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart' as fireui;
import 'package:quiz/modal/repository.dart';
import 'package:quiz/view_modal/login/bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
    return (context) => BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginView(),
        );
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    RepositoryProvider.of<CentralRepository>(context).getHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(FirebaseAuth.instance.currentUser?.displayName ?? 'Quiz'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
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
            _getPopData(score, context);
          }
        },
        builder: (blocContext, blocState) {
          if (blocState is LoginInitial || blocState is LogoutSuccess) {
            return _loginProviderScreen(context);
          }
          if (blocState is LoginSuccess) return _loggedScreen(context);

          if (blocState is LoginSuccessScore) {
            return _loggedScreen(context, score: blocState.score);
          }

          return _circularIndi();
        },
      ),
    );
  }

  _getPopData(Future<dynamic> data, BuildContext cont) async {
    // converting the Future[data] into a Map Object
    Map<String, dynamic> scoreObject = await data;
    // for debugging purporse to print the score
    // debugPrint(scoreObject['score'].toString());

    // updating the state by requesting an even and passing score to it
    cont.read<LoginBloc>().add(LoginScoreRequestedEvent(scoreObject));
    // uploading the score to firestore
    RepositoryProvider.of<CentralRepository>(context)
        .uploadScores(scoreObject['score'].toString());
  }

  // The minimum score is 0 and the Max is 100
  Widget _loggedScreen(BuildContext context, {int score = -1}) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // if score has some value then show score
            score >= 0 ? Text('Your total score is $score') : const SizedBox(),
            const Spacer(),
            ElevatedButton(
              onPressed: () =>
                  context.read<LoginBloc>().add(LoginRequestedEvent()),
              child: const Text('Start Quiz'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.read<LoginBloc>().add(LogoutRequestedEvent()),
              child: const Text('Sign out'),
            ),
            const Spacer(),
          ],
        ),
      );

  Widget _circularIndi() => const Center(child: CircularProgressIndicator());

  Widget _loginProviderScreen(BuildContext context) => Center(
        child: fireui.AuthFlowBuilder<fireui.OAuthController>(
          config: const fireui.GoogleProviderConfiguration(
              clientId:
                  '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com'),
          auth: FirebaseAuth.instance,
          listener: (oldState, newState, controller) {
            if (newState is fireui.SignedIn) {
              context.read<LoginBloc>().add(LoginRequestedEvent());
            }
            // calling setstate
            // only on state changes
            setState(() {});
          },
          builder: (context, state, ctrl, child) {
            if (state is fireui.SigningIn ||
                state is fireui.CredentialReceived ||
                state is fireui.CredentialLinked) {
              const Center(child: CircularProgressIndicator());
            }
            return ElevatedButton(
              onPressed: () async {
                await ctrl.signInWithProvider(TargetPlatform.android);
              },
              child: const Text('Google Sign-In'),
            );
          },
        ),
      );
}
