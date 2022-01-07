import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/view_modal/quiz/bloc/quiz_bloc.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  static WidgetBuilder page(BuildContext context) {
    return (context) => BlocProvider(
          create: (_) => QuizBloc(),
          child: const QuizView(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quiz'),
      ),
      body: const Center(
        child: Text('Quiz Starts here'),
      ),
    );
  }
}
