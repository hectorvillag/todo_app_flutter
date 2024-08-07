import 'package:dartz/dartz.dart' as dartz;
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';

class FetchTasks{
  FetchTasks(this.taskRepository);

  final TaskRepository taskRepository;
  //TODO: cambiar la excepcion creada
  Future<dartz.Either<Exception,List<Task>>> call() async{
    try{
      final tasks = await taskRepository.getAll();
      tasks.sort((a,b) => a.id!.compareTo(b.id!));
      return dartz.Right(tasks);
    }catch (e){
      return dartz.Left(Exception(e.toString()));
    }
  }
}