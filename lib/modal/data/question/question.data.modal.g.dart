// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.data.modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDataModal _$QuestionDataModalFromJson(Map<String, dynamic> json) =>
    QuestionDataModal(
      question: json['question'] as String,
      answer: json['correct_answer'] as String,
      options: (json['incorrect_answers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$QuestionDataModalToJson(QuestionDataModal instance) =>
    <String, dynamic>{
      'question': instance.question,
      'correct_answer': instance.answer,
      'incorrect_answers': instance.options,
    };
