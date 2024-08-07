import 'package:hive/hive.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/models/task_clone.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/task_dto.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/infrastructure/task_mapper.dart';

class TasksLocalDataSource {
  Box<TaskDTO>? box;

  TasksLocalDataSource() {
    box = null;
  }

  Future<void> init() async {
    box = await Hive.openBox<TaskDTO>('tasks');
  }

  Future<Task> add(Task task) async {
    if (box == null) {
      await init();
    }
    int key = await box!.add(TaskMapper().mapTaskToTaskDto(task));

    return TaskClone(task).clone(id: key);
  }

  Future<void> delete(Task task) async {
    if (box == null) {
      await init();
    }

    return await box!.delete(task.id);
  }

  Future<Task> update(Task task) async {
    if (box == null) {
      await init();
    }
    TaskDTO taskDTO = TaskMapper().mapTaskToTaskDto(task);
    await box!.put(task.id, taskDTO);

    return TaskClone(task).clone();
  }

  Future<List<Task>> getAll() async {
    if (box == null) {
      await init();
    }

    var keys = box!.keys.toList();
    List<Task> tasks = [];
    for (int key in keys) {
      TaskDTO? taskDTO = box!.get(key);
      tasks.add(TaskMapper().mapTaskDtoToTask(taskDTO!, key));
    }
    return tasks;
  }
}
