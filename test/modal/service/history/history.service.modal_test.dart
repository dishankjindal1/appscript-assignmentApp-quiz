import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz/modal/data/data.dart';
import 'package:quiz/modal/service/service.dart';

class MockHistoryServiceModal extends Mock implements HistoryServiceModal{}
class MockHistoryDataModal extends Mock implements HistoryDataModal {}

void main() {
  group('Testing History Service Modal:-', (){
    MockHistoryServiceModal? historyService;
    setUp((){
      historyService ??= MockHistoryServiceModal();
    });

    test('get list of history data', () async {
      when(()=>historyService?.getList('123')).thenAnswer((_) async => <MockHistoryDataModal>[]);
      expectLater(await historyService?.getList('123'), isA<List<MockHistoryDataModal>>());
    });

    
    test('upload data to firestore', () async {
      when(()=>historyService?.uploadScore('123','50')).thenAnswer((_) async => await Future.value());
      await expectLater( historyService?.uploadScore('123','50'), isA<void>());
    });
  });
}