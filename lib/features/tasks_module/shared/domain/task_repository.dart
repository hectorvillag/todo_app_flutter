import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';

abstract class TaskRepository{
  Future<List<Task>> getAll();
  Future<Task> add(Task task);
  Future<void> delete(Task task);
  Future<Task> update(Task task);
}