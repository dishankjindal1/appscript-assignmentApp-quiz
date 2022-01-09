import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class LoginScreenProvider extends StatelessWidget {
  const LoginScreenProvider(this.runFunctionLocal, {Key? key})
      : super(key: key);

  final Function runFunctionLocal;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AuthFlowBuilder<OAuthController>(
        config: const GoogleProviderConfiguration(
            clientId:
                '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com'),
        auth: FirebaseAuth.instance,
        listener: (oldState, newState, controller) {
          if (newState is SignedIn) {
            runFunctionLocal();
          }
        },
        builder: (context, state, ctrl, child) {
          if (state is SigningIn ||
              state is CredentialReceived ||
              state is CredentialLinked) {
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
}
