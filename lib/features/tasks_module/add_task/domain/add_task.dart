import 'package:todo_app_flutter/features/logger/app_logger.dart';
import 'package:todo_app_flutter/features/tasks_module/add_task/domain/error_adding_task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';
import 'package:dartz/dartz.dart' as dartz;
import '../../shared/domain/models/task.dart';

class AddTask {
  AddTask(this.repository, this.logger);
  final TaskRepository repository;
  final AppLogger logger;

  Future<dartz.Either<ErrorAddingTask, Task>> call(Task task) async {
    try {
      Task newTask = await repository.add(task);
      return dartz.Right(newTask);
    } catch (e) {
      logger.error('No se creo la tarea', error: e);
      return dartz.Left(ErrorAddingTask(e.toString()));
    }
  }
}
