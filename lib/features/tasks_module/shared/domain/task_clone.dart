import 'package:todo_app_flutter/features/tasks_module/shared/domain/task.dart';

class TaskClone extends Task {
  TaskClone(Task task) : super(id: task.id,title: task.title,description: task.description,isDone: task.isDone);
  

  Task clone({String? id, String? title, String? description, bool? isDone}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
