import 'package:dartz/dartz.dart' as dartz;
import 'package:todo_app_flutter/features/tasks_module/list_tasks/domain/error_getting_tasks.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';

class FetchTasks{
  FetchTasks(this.taskRepository);

  final TaskRepository taskRepository;
  Future<dartz.Either<ErrorGettingTasks,List<Task>>> call() async{
    try{
      final tasks = await taskRepository.getAll();
      tasks.sort((a,b) => a.id!.compareTo(b.id!));
      return dartz.Right(tasks);
    }catch (e){
      return dartz.Left(ErrorGettingTasks(e.toString()));
    }
  }
}