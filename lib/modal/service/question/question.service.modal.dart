import 'package:dio/dio.dart';
import 'package:quiz/modal/data/question/question.data.modal.dart';
import 'package:quiz/modal/utils/exception/exception.utils.modal.dart';

const String serverUrl =
    'https://opentdb.com/api.php?amount=10&category=27&type=multiple&encode=base64';

class QuestionServiceModal {
  Future<List<QuestionDataModal>> getListOfQuestion() async {
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
