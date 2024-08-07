import 'package:logger_plus/logger_plus.dart';
import 'package:todo_app_flutter/features/logger/app_logger.dart';

class AppLoggerPlus implements AppLogger{
  final logger = Logger();

  @override
  void info(String info) {
    logger.i(info);
  }

  @override
  void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    logger.e(message, error, stackTrace);
  }
}
