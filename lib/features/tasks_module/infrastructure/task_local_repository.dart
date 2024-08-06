import 'package:todo_app_flutter/features/tasks_module/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/domain/task_builder.dart';
import 'package:todo_app_flutter/features/tasks_module/domain/task_repository.dart';

class TaskLocalRepository implements TaskRepository {
  TaskLocalRepository() {
    _tasks = <Task>[
      TaskBuilder()
          .withTitle('titulo 1')
          .withDescription('Descripcion 1')
          .build(),
      TaskBuilder()
          .withTitle('titulo 2')
          .withDescription('Descripcion 3')
          .build(),
      TaskBuilder()
          .withTitle('titulo 1')
          .withDescription('Descripcion 4')
          .build()
    ];
  }

  late List<Task> _tasks;

  @override
  Future<void> add(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> delete(Task taskToDelete) async {
    final result = _tasks.where((task) => task.id == taskToDelete.id).toList();
    if (result.isEmpty) {
      //TODO: manejar de otra manera esta excepcion
      throw Exception('tarea no encontrada');
    }
    _tasks.remove(result.first);
  }

  @override
  Future<List<Task>> getAll() async {
    return _tasks;
  }

  @override
  Future<void> update(Task taskToUpdate) async {
    final result = _tasks.where((task) => task.id == taskToUpdate.id).toList();
    if (result.isEmpty) {
      //TODO: manejar de otra manera esta excepcion
      throw Exception('tarea no encontrada');
    }
    _tasks.remove(result.first);
    _tasks.add(taskToUpdate);
  }
}
