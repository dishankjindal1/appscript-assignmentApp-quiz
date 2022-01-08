import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:quiz/modal/repository.dart';
import 'package:quiz/view/utils/custom.progress.bar.dart';
import 'package:quiz/view_modal/progress/bloc/progress_bloc.dart';
import 'package:quiz/view_modal/quiz/bloc/quiz_bloc.dart';

typedef AnimationCallBackFunc = void Function(AnimationController);

class QuizView extends StatefulWidget {
  const QuizView({Key? key}) : super(key: key);

  static WidgetBuilder page() {
    return (context) => MultiBlocProvider(
          providers: [
            BlocProvider<QuizBloc>(create: (_) => QuizBloc()),
            BlocProvider<ProgressBloc>(create: (_) => ProgressBloc()),
          ],
          child: const QuizView(),
        );
  }

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final _pageController = PageController();

  final _formKey = GlobalKey<FormBuilderState>();

  late AnimationController animationCtrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz ${FirebaseAuth.instance.currentUser!.displayName}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _progressConsumer(context),
          CustomProgressBar(
              (AnimationController ctrl) => animationCtrl = ctrl),
          const SizedBox(height: 25),
          _blocConsumer(
            context,
          ),
        ],
      ),
    );
  }


  _blocConsumer(BuildContext context) {
    Map<String, dynamic> quizAnswer = {};

    var deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizInitialComplete) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: deviceSize.width,
                    height: deviceSize.width,
                    child: PageView.builder(
                      pageSnapping: false,
                      padEnds: false,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.list[index].question,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 32.0),
                              child: SizedBox(
                                width: deviceSize.width,
                                height: 250,
                                child: FormBuilderRadioGroup<String>(
                                    key: Key('formvalue@$index'),
                                    name: 'formvalue@$index',
                                    initialValue: state.list[index].options[1],
                                    // Using onChnage for a workaround a glitch // Focus node
                                    onChanged: (value) => _changedRadio(value),
                                    orientation: OptionsOrientation.vertical,
                                    wrapCrossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    options: (state.list[index].options
                                            .map((e) => FormBuilderFieldOption(
                                                value: e.toString()))
                                            .toList() +
                                        [
                                          FormBuilderFieldOption(
                                              value: state.list[index].answer)
                                        ])
                                      ..shuffle(Random(5))),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Page is Starting from 0 to 9 total 10 questions
                        var page = _pageController.page?.round() ?? 1;

                        setState(() {
                          animationCtrl.animateTo((page+1)/10);
                        });

                        _formKey.currentState?.save();
                        debugPrint(_formKey.currentState?.value.toString());
                        quizAnswer.addAll(_formKey.currentState!.value);

                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        if (page >= 9) {
                          debugPrint(quizAnswer.toString());
                          var count = 0;
                          var index = 0;
                          quizAnswer.forEach((key, value) {
                            if (value == state.list[index].answer) {
                              count += 10;
                            }
                            index++;
                          });

                          Navigator.pop<Map<String, dynamic>>(
                              context, {'result': true, 'score': count});
                        }
                      },
                      child: const Text('submit & next'),
                    ),
                  ),
                ],
              ),
            ),
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

  _changedRadio(String? value) {
    var current = _pageController.page?.round() ?? 1;
    _pageController.jumpToPage(current);
  }
}
