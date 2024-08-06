import 'package:get_it/get_it.dart';
import 'package:todo_app_flutter/features/tasks_module/domain/fetch_tasks.dart';
import 'package:todo_app_flutter/features/tasks_module/domain/task_repository.dart';
import 'package:todo_app_flutter/features/tasks_module/infrastructure/task_local_repository.dart';

final serviceLocator = GetIt.instance;

void setupTasksDI() {
  serviceLocator.registerFactory<TaskRepository>(() => TaskLocalRepository());
  serviceLocator.registerFactory(() => FetchTasks(serviceLocator()));
}