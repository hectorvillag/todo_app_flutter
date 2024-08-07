class TechnicalException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  TechnicalException(this.message, [this.stackTrace]);
}
