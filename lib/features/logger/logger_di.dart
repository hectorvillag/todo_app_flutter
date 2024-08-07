import 'package:todo_app_flutter/features/logger/app_logger.dart';
import 'package:todo_app_flutter/features/logger/app_logger_plus.dart';
import 'package:todo_app_flutter/service_locator.dart';

void setupLoggerDI() {
  serviceLocator.registerLazySingleton<AppLogger>(() => AppLoggerPlus());
}