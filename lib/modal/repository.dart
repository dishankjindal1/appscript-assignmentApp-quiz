import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:quiz/modal/modal.dart';

class CentralRepository {
  final QuestionServiceModal _questionServiceModal = QuestionServiceModal();
  final HistoryServiceModal _historyServiceModal = HistoryServiceModal();
  final Logger _logger = Logger();

  Future<List<QuestionDataModal>> getQuestionList() async {
    return await _questionServiceModal.getList();
  }

  Future<List<HistoryDataModal>> getHistoryList() async {
    return await _historyServiceModal
        .getList(FirebaseAuth.instance.currentUser?.uid ?? '123');
  }

  Future<void> uploadScores(String score) async {
    var uuid = FirebaseAuth.instance.currentUser?.uid;

    if (uuid != null && int.parse(score) >= 0) {
      await _historyServiceModal.uploadScore(uuid, score);
    } else if (uuid == null) {
      throw FirebaseUserNotFoundException('uid is null');
    } else if (int.parse(score) < 0) {
      throw InvalidScoreException('Score is less than 0');
    } else {
      _logger.e('Unknown Error: score not updated.');
    }
  }
}
