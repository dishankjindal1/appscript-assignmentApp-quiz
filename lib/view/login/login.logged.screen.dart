import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                onPressed: () =>
                    context.read<LoginBloc>().add(LoginRequestedEvent()),
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
}
