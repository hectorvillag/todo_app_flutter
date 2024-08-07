import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/tasks_local_data_source.dart';

class TaskLocalRepository implements TaskRepository {
  TaskLocalRepository(this.tasksLocalDataSource);

  final TasksLocalDataSource tasksLocalDataSource;

  @override
  Future<Task> add(Task task) async {
    return await tasksLocalDataSource.add(task);
  }

  @override
  Future<void> delete(Task taskToDelete) async {
    return tasksLocalDataSource.delete(taskToDelete);
  }

  @override
  Future<List<Task>> getAll() async {
    return await tasksLocalDataSource.getAll();
  }

  @override
  Future<Task> update(Task taskToUpdate) async {
    return tasksLocalDataSource.update(taskToUpdate);
  }
}
