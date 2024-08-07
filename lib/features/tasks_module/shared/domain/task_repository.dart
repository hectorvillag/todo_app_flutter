import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';

abstract class TaskRepository{
  Future<List<Task>> getAll();
  Future<void> add(Task task);
  Future<void> delete(Task task);
  Future<void> update(Task task);
}