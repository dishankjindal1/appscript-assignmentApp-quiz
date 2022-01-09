import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz/modal/data/data.dart';
import 'package:quiz/modal/service/question/question.service.modal.dart';
import 'package:quiz/modal/utils/utils.dart';

class MockQuestionDataModal extends Mock implements QuestionDataModal {}

class MockQuestionServiceModal extends Mock implements QuestionServiceModal {}

void main() {
  group('Testing Central Repository :-', () {
    MockQuestionServiceModal? questionService;

    setUp(() {
      questionService ??= MockQuestionServiceModal();
    });
    test('Get a List of Question', () async {
      when(() => questionService!.getList())
          .thenAnswer((_) async => <MockQuestionDataModal>[]);
      expectLater(
          await questionService!.getList(), isA<List<MockQuestionDataModal>>());
    });

    test('Response Exception when Getting a List of Question ', () async {
      when(() => questionService!.getList())
          .thenThrow(ResponseStatusException('message'));
      expect(() => questionService!.getList(),
          throwsA(isA<ResponseStatusException>()));
    });
  });
}
