
import 'package:quiz/modal/modal.dart';

class CentralRepository {
  final QuestionServiceModal _questionServiceModal = QuestionServiceModal();

  Future<List<QuestionDataModal>> getList() async {
    return await _questionServiceModal.getListOfQuestion();
  }
}