import 'package:rxdart/subjects.dart';
import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';

class TasksStreamState {
  final _tasksStreamController = BehaviorSubject<List<Task>>.seeded(const []);

  Stream<List<Task>> get streamEntities =>
      _tasksStreamController.asBroadcastStream();

  List<Task> get entities => _tasksStreamController.value;

  deleteAll(){
    _tasksStreamController.add([]);
  }

  replaceAll(List<Task> tasks){
    _tasksStreamController.add(tasks);
  }

  add(Task task) {
    final tasks = [..._tasksStreamController.value];
    tasks.add(task);
    _tasksStreamController.add(tasks);
  }

  delete(Task task) {
    final tasks = [..._tasksStreamController.value];
    final modelIndex = tasks.indexWhere((it) => it.id == task.id);
    if (modelIndex >= 0) {
      tasks.removeAt(modelIndex);
      _tasksStreamController.add(tasks);
    }
  }

  update(Task task) {
    final tasks = [..._tasksStreamController.value];
    final taskIndex = tasks.indexWhere((it) => it.id == task.id);
    if (taskIndex >= 0) {
      tasks[taskIndex] = task;
      _tasksStreamController.add(tasks);
    }
  }

}