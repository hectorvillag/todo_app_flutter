import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_builder.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task_repository.dart';
import 'package:uuid/uuid.dart';
//TODO: eliminar uso de uuid
const  Uuid uuid = Uuid();
class TaskLocalRepository implements TaskRepository {
  TaskLocalRepository() {
    _tasks = <Task>[
      TaskBuilder()
        .withId(uuid.v1())
          .withTitle('titulo 1')
          .withDescription('Descripcion 1')
          .build(),
      TaskBuilder()
      .withId(uuid.v1())
          .withTitle('titulo 2')
          .withDescription('Descripcion 3')
          .build(),
      TaskBuilder()
          .withId(uuid.v1())
          .withTitle('titulo 1')
          .withDescription('Descripcion 4')
          .build()
    ];
  }

  late List<Task> _tasks;

  @override
  Future<Task> add(Task task) async {
    _tasks.add(task);
    return task;
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
  Future<Task> update(Task taskToUpdate) async {
    final result = _tasks.where((task) => task.id == taskToUpdate.id).toList();
    if (result.isEmpty) {
      //TODO: manejar de otra manera esta excepcion
      throw Exception('tarea no encontrada');
    }
    _tasks.remove(result.first);
    _tasks.add(taskToUpdate);
    return taskToUpdate;
  }
}
