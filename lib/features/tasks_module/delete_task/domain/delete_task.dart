import 'package:dartz/dartz.dart' as dartz;
import 'package:todo_app_flutter/features/logger/app_logger.dart';
import 'package:todo_app_flutter/features/tasks_module/delete_task/domain/error_deleting_task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';
import 'package:todo_app_flutter/shared/domain/nothing.dart';

class DeleteTask{
  DeleteTask(this.repository, this.logger);
  final TaskRepository repository;
  final AppLogger logger;
  
  Future<dartz.Either<ErrorDeletingTask, Nothing>> call(Task task) async {
    try {
      await repository.delete(task);
      return const dartz.Right(Nothing());
    } catch (e) {
      logger.error('No se creo la tarea', error: e);
      return dartz.Left(ErrorDeletingTask(e.toString()));
    }
  }
}