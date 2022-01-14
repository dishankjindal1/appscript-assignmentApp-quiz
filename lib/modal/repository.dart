export './data/data.dart';
export './service/service.dart';
export './utils/utils.dart';

import './data/data.dart';
import './service/service.dart';
import './utils/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class CentralRepository {
  late final QuestionServiceModal _questionServiceModal;
  late final HistoryServiceModal _historyServiceModal;
  late final FirebaseAuth _firebaseAuth;
  late final Logger _logger;

  CentralRepository({required String serverUrl}) {
    _questionServiceModal = QuestionServiceModal(serverUrl);
    _historyServiceModal = HistoryServiceModal(serverUrl);
    _firebaseAuth = FirebaseAuth.instance;
    _logger = Logger();
  }

  Future<User?> get firebaseUserAuth async {
    return await _firebaseAuth.userChanges().distinct().where((event) {
      if (event != null && event.emailVerified) {
        return true;
      }
      return false;
    }).first;
  }

  Future<List<QuestionDataModal>> getQuestionList() async {
    return await _questionServiceModal.getList();
  }

  Future<List<HistoryDataModal>> getHistoryList() async {
    return await _historyServiceModal
        .getList(_firebaseAuth.currentUser?.uid ?? '123');
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

  Future<void> signout() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> signin() async {}
}
