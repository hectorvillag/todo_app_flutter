abstract class AppLogger {
  void info(String info);

  void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  });
}
