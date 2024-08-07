import 'package:todo_app_flutter/features/tasks_module/change_task_status/domain/change_task_status.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/add_task.dart';
import 'package:todo_app_flutter/features/tasks_module/list_tasks/domain/fetch_tasks.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/task_local_repository.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_local_data_source.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_stream.dart';
import 'package:todo_app_flutter/service_locator.dart';

void setupTasksDI() {
  serviceLocator.registerLazySingleton<TasksLocalDataSource>(() => TasksLocalDataSource());
  serviceLocator.registerLazySingleton<TaskRepository>(() => TaskLocalRepository(serviceLocator()));
  serviceLocator.registerFactory(() => FetchTasks(serviceLocator()));
  serviceLocator.registerFactory(() => AddTask(serviceLocator(),serviceLocator()));
  serviceLocator.registerLazySingleton(() => ChangeTaskStatus(serviceLocator(), serviceLocator()));
  serviceLocator.registerLazySingleton(() => TasksStreamState());
}
