part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class QuizStartRequested extends QuizEvent {
  final Future<List<QuestionDataModal>> listOfQuestion;
  const QuizStartRequested(this.listOfQuestion);
}

class QuizIsFinished extends QuizEvent {
  final int current;
  final int end;
  const QuizIsFinished({required this.current, required this.end});
}
