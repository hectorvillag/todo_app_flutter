import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/task_dto.dart';

class TaskMapper {
  Task mapTaskDtoToTask(TaskDTO taskDto, int? id) {
    return Task(
      id: id,
      title: taskDto.title,
      description: taskDto.description,
      isDone: taskDto.isDone,
    );
  }

  TaskDTO mapTaskToTaskDto(Task task) {
    return TaskDTO(
      title: task.title,
      description: task.description,
      isDone: task.isDone,
    );
  }
}
