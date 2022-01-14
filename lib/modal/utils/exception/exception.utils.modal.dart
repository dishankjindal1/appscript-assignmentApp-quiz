abstract class BaseException implements Exception {
  final String? _prefix;
  final String? _message;

  BaseException(this._prefix, this._message);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class ResponseStatusException extends BaseException {
  ResponseStatusException(String? message)
      : super("Error Response from Server :", message);
}

class FireStoreScoreUploadException extends BaseException {
  FireStoreScoreUploadException(String? message)
      : super("Firestore Error :", message);
}

class FirebaseUserNotFoundException extends BaseException {
  FirebaseUserNotFoundException(String? message)
      : super('Firebase User not found Error :', message);
}

class InvalidScoreException extends BaseException {
  InvalidScoreException(String? message)
      : super('Invalid Score Exception :', message);
}

class UnknownHttpException extends BaseException {
  UnknownHttpException(String? message)
      : super('Unknown Server Error', message);
}

class InvalidServerUrlException extends BaseException {
  InvalidServerUrlException()
      : super("Invalid Server Url :-", "Please provide correct url");
}
