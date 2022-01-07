import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:quiz/view_modal/login/bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
    return (context) => BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginView(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).popAndPushNamed('/quiz');
          }
        },
        builder: (context, state) {
          if (state is LoginInitial) {
            return Center(
              child: AuthFlowBuilder<OAuthController>(
                config: const GoogleProviderConfiguration(
                    clientId:
                        '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com'),
                listener: (oldState, newState, controller) {
                  if (state is SignedIn) {
                    context.read<LoginBloc>().add(LoginRequestedEvent());
                  }
                },
                builder: (context, state, ctrl, child) {
                  if (state is SignedIn) {
                    return const Center(child: Text('Signed In'));
                  } else if (state is AuthFailed) {
                    return const Center(child: Text('Failed'));
                  } else if (state is SigningIn) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            await ctrl
                                .signInWithProvider(TargetPlatform.android);
                            context
                                .read<LoginBloc>()
                                .add(LoginRequestedEvent());
                          },
                          child: Text(
                              '${FirebaseAuth.instance.currentUser?.displayName ?? 'None'} in BlocConsumer LoginView')),
                    );
                  }
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
