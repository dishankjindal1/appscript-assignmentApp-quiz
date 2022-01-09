import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz/modal/data/question/question.data.modal.dart';
import 'package:quiz/modal/service/question/question.service.modal.dart';

class MockQuestionServiceModal extends Mock implements QuestionServiceModal {}

class MockQuestionDataModal extends Mock implements QuestionDataModal {}

void main() {
  group('Testing Question Serivce Modal class :-', () {
    QuestionServiceModal? fakeQuestionServiceModal;

    setUp((){
       fakeQuestionServiceModal ??= MockQuestionServiceModal();
    });

    test('getListOfQuestion method', () async {
      when(() => fakeQuestionServiceModal!.getList()).thenAnswer((_) async =>
          await Future.value(<MockQuestionDataModal>[]));
      expect(await fakeQuestionServiceModal!.getList(), isA<List<MockQuestionDataModal>>());
    });
  });
}
