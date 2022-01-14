import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/modal/repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {

final CentralRepository _centralRepository;

  QuizBloc(this._centralRepository) : super(QuizLoading()) {
    on<QuizStartRequested>(_quizStart);
  }

  _quizStart(QuizStartRequested event, Emitter<QuizState> emit) async {
    emit(QuizLoading());

    var list = await event.listOfQuestion;

    list = list
        .map((e) => QuestionDataModal(
              question: utf8.decode(base64.decode(e.question)),
              answer: utf8.decode(base64.decode(e.answer)),
              options:
                  e.options.map((q) => utf8.decode(base64.decode(q))).toList(),
            ))
        .toList();
    emit(QuizInitialComplete(list));
  }
}
