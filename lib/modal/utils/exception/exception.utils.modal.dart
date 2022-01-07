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
      : super("Error Response from Server", message);
}

class UnknownHttpException extends BaseException {
  UnknownHttpException(String? message)
      : super('Unknown Server Error', message);
}
