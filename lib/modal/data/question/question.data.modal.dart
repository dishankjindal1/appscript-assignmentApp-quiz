import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.data.modal.g.dart';

@JsonSerializable()
class QuestionDataModal extends Equatable {
  final String question;
  @JsonKey(name: 'correct_answer')
  final String answer;
  @JsonKey(name: 'incorrect_answers')
  final List<String> options;

  const QuestionDataModal({
    required this.question,
    required this.answer,
    required this.options,
  });

  factory QuestionDataModal.fromJson(Map<String, dynamic> json) =>
      _$QuestionDataModalFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDataModalToJson(this);

  @override
  List<Object?> get props => [question, answer];
}
