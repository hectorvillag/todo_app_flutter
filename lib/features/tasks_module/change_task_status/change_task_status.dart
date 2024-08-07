import 'package:dartz/dartz.dart' as dartz;
import 'package:todo_app_flutter/features/logger/app_logger.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_clone.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';

class ChangeTaskStatus {
  ChangeTaskStatus(this.taskRepository,this.logger);

  final TaskRepository taskRepository;
  final AppLogger logger;

  Future<dartz.Either<Exception, Task>> call(Task task,bool isDone) async {
    try {
      Task taskToUpdate = TaskClone(task).clone(isDone:  isDone);

      Task updatedTask = await taskRepository.update(taskToUpdate);
      
      return dartz.Right(updatedTask);
    } catch (e) {
      logger.error('No se actualizo la tarea', error: e);
      return dartz.Left(Exception('Ocurrio un error'));
    }
  }
}