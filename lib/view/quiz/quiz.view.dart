import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/repository.dart';
import 'package:quiz/view_modal/quiz/bloc/quiz_bloc.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
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
        title: Text('Quiz ${FirebaseAuth.instance.currentUser!.displayName}'),
      ),
      body: _blocConsumer(context),
    );
  }

  _blocConsumer(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is QuizInitial) {
          // var repoListOfQuestions =
          //     RepositoryProvider.of<CentralRepository>(context).getList();
          // context.read<QuizBloc>().add(QuizStartRequested(repoListOfQuestions));
        }
      },
      builder: (context, state) {
        if (state is QuizInitialComplete) {
          return PageView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Center(
                child: Text('Dishank ${state.list[index].question}'),
              );
            },
          );
        }
        if (state is QuizLoading) {
          var repoListOfQuestions =
              RepositoryProvider.of<CentralRepository>(context).getList();
          context.read<QuizBloc>().add(QuizStartRequested(repoListOfQuestions));

          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Text('Unknown $state'),
        );
      },
    );
  }
}
