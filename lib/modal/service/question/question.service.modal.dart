import 'package:dio/dio.dart';
import 'package:quiz/modal/data/question/question.data.modal.dart';
import 'package:quiz/modal/utils/exception/exception.utils.modal.dart';

class QuestionServiceModal {
  late final String serverUrl;

  QuestionServiceModal(this.serverUrl);

  Future<List<QuestionDataModal>> getList() async {
    var dio = Dio();
    try {
      var res = await dio.get(serverUrl);

      if (res.data['response_code'] != 0) {
        throw ResponseStatusException('Error from modal/service/question');
      } else {
        var listOfQuestions = (res.data['results'] as List)
            .map((e) => QuestionDataModal.fromJson(e))
            .toList();
        return listOfQuestions;
      }
    } finally {
      dio.close();
    }
  }

  statusResponse(Response res) {
    switch (res.statusCode) {
      case 200:
        return res.data;
      default:
        throw UnknownHttpException('unkown Error');
    }
  }
}
