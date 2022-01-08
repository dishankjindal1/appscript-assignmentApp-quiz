part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizInitialComplete extends QuizState {
  final List<QuestionDataModal> list;
  const QuizInitialComplete(this.list);
}

class QuizLoading extends QuizState {}

class QuizContinue extends QuizState {}
