import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:quiz/view/utils/utils.dart';


class LoginScreenProvider extends StatelessWidget {
  const LoginScreenProvider(this.authStateChangeAction, {Key? key})
      : super(key: key);

  final AuthStateChangeActionVoidCallback authStateChangeAction;
  @override
  Widget build(BuildContext context) {
    // runFunctionLocal();
    return SignInScreen(
      auth: FirebaseAuth.instance,
      providerConfigs: const [
        GoogleProviderConfiguration(
            clientId:
                '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com')
      ],
      actions: [AuthStateChangeAction(authStateChangeAction),],
    );
    // return Center(
    //   child: AuthFlowBuilder<OAuthController>(
    //     config: const GoogleProviderConfiguration(
    //         clientId:
    //             '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com'),
    //     auth: FirebaseAuth.instance,
    //     listener: (oldState, newState, controller) {
    //       if (newState is SignedIn) {
    //         runFunctionLocal();
    //       }
    //     },
    //     builder: (context, state, ctrl, child) {
    //       if (state is SigningIn ||
    //           state is CredentialReceived ||
    //           state is CredentialLinked) {
    //         const Center(child: CircularProgressIndicator());
    //       }
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 64.0),
    //         child: SignInScreen(
    //           auth: FirebaseAuth.instance,
    //           providerConfigs: const [
    //             GoogleProviderConfiguration(
    //                 clientId:
    //                     '763499512736-2rhn4cjlgaqlr5mj2oknoj9u4ifigfot.apps.googleusercontent.com')
    //           ],
    //         ),
    //       );
    //       // return TextButton(
    //       //   style: ButtonStyle(
    //       //       backgroundColor:
    //       //           MaterialStateProperty.all<Color>(Colors.black26)),
    //       //   onPressed: () async {
    //       //     await ctrl.signInWithProvider(TargetPlatform.android);
    //       //   },
    //       //   child: const ListTile(
    //       //     tileColor: Colors.white24,
    //       //     title: Text('Google Sign-In'),
    //       //   ),
    //       // );
    //     },
    //   ),
    // );
  }
}
