import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/modal/data/question/question.data.modal.dart';

void main() {
  group('Testing: Question Data Modal', () {
    Dio? dio;
    Response? res;

    setUp(() async {
      dio ??= Dio();
      res = await dio!.get('serverUrl');
    });

    tearDown(() {
      dio!.close();
    });

    test('test if the data mocks', () async {
      List<QuestionDataModal> questionDataModal = (res!.data['results'] as List)
          .map((json) => QuestionDataModal.fromJson(json))
          .toList();
      // debugPrint(questionDataModal[0].question);
      expect(questionDataModal, isA<List<QuestionDataModal>>());
    });
  });
}
